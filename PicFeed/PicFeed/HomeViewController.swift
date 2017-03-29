//
//  HomeViewController.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/27/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidAppear(_ animated:Bool) {
    super.viewDidAppear(animated)
        
    filterButtonTopConstraint.constant = 8
    postButtonBottomConstraint.constant = 8
        
    
    UIView.animate(withDuration: 0.6) {
    self.view.layoutIfNeeded()
    }

    }
    
    
    override func viewDidLoad() {
        //This is Override beacuse we are overriding the superclass
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = view.bounds.width / 90
        //This is how you do ANIMATIONS^
        
        // Do any additional setup after loading the view.
    }
    //handles each source type
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker, animated: true, completion: nil)
        // This is for the imagePickerController, see docs for options
    }
    
    
    // if the user presses cancel button this comes in play
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
        //imageView.image = image
        self.imageView.image = originalImage
        Filters.originalImage = originalImage
        //this allows funcionality to dismiss the imageview

        }
        print("info: \(info)")
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func imageTapped(_ sender: Any) {
        print("User tapped Image")
        self.presentActionSheet()
        //This is basically an event listener
        //It calls all the actions that are located in the function underneath, that fires off the camera and photo library and cancel button.
    }
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        if let image = self.imageView.image{
            
            let newPost = Post(image: image)
            CloudKit.shared.save(post: newPost, completion: { (success) in
                
                if success {
                    print("Saved post successfully to CloudKit!")
                } else {
                    print("We did not successfully post to CloudKit...")
                }
            })
        }
    }
    
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        
        guard let image = self.imageView.image else { return }
        
        let alertController = UIAlertController(title: "Filter", message: "Please select a filter", preferredStyle: .alert)
        
        let blackAndWhiteAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
            Filters.filter(name: .blackAndWhite, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            Filters.filter(name: .vintage, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        let coldAction = UIAlertAction(title: "Cold", style: .default) { (action) in
            Filters.filter(name: .coldEffect, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        let devilAction = UIAlertAction(title: "Devil", style: .default) { (action) in
            Filters.filter(name: .devilEffect, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        let posterizeAction = UIAlertAction(title: "Posterize", style: .default) { (action) in
            Filters.filter(name: .posterizeEffect, image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        let resetAction = UIAlertAction(title: "Reset Image", style: .destructive) { (action) in
            self.imageView.image = Filters.originalImage
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(blackAndWhiteAction)
        alertController.addAction(vintageAction)
        alertController.addAction(coldAction)
        alertController.addAction(devilAction)
        alertController.addAction(posterizeAction)
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    //actions when the user clicks on it
    func presentActionSheet(){
        
        let actionSheetController = UIAlertController(title: "Source", message: "Please Select Sourse Type", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .camera)
        }
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraAction.isEnabled = false
        //This does not let the User use the camera option if the user doesn't have a camera on the device.^
        }
        
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
}
