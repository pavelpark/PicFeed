//
//  Filters.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/28/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

enum FilterName: String {
    case vintage = "CIPhotoEffectTransfer"
    case blackAndWhite = "CIPhotoEffectMono"
    case coldEffect = "CIPhotoEffectFade"
    case devilEffect = "CIColorInvert"
    case posterizeEffect = "CIColorPosterize"
}

typealias FilterCompletion = (UIImage?) -> ()

class Singleton{
    
    static let shared = Singleton()
    private init () {
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(api: .openGLES2)
        context = CIContext(eaglContext: eaglContext!, options: options)

    }

    let context : CIContext
}
class Filters {
    
    static let shared = Filters()
    private init () {}
    
     var originalImage : UIImage?
    //lets us rest to the original image
    
    
        let ciContext = Singleton.shared.context
    
        func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to creat CIFilter") }
            
            let coreImage = CIImage(image: image)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            
            //GPU Context
            //Get the final image from using the GPU
            //these will always be the 3 lines that are used
            guard let outputImage = filter.outputImage else { fatalError("Failed to get the output image from Filter.") }
            
            if let cgImage = self.ciContext.createCGImage(outputImage, from: outputImage.extent) {
                
                let finalImage = UIImage(cgImage: cgImage)
                
                OperationQueue.main.addOperation {
                    completion(finalImage)
                }
                
            } else {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
        }
    }
}



