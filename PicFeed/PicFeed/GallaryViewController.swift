//
//  GallaryViewController.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/29/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

protocol GallaryViewControllerDelegate : class {
    func galaryController(didSelect image: UIImage)
}

class GallaryViewController: UIViewController {
    
    weak var delegate : GallaryViewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    var allPosts = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.collectionViewLayout = GallaryCollectionViewLayout(columns: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    func update() {
        CloudKit.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
            
        }
    }

}

//MARK: UICollectionViewDataSorce Extension
extension GallaryViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryCell.identifier, for: indexPath) as! GallaryCell
        
        cell.post = self.allPosts[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let selectedPost = self.allPosts[indexPath.row]
        
        delegate.galaryController(didSelect: selectedPost.image)
        
    }
}
