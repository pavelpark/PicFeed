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


class Filters {
    
    static var originalImage = UIImage()
    //lets us rest to the original image
    
    class func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to creat CIFilter") }
            
            let coreImage = CIImage(image: image)
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            
            //GPU Context 
            let options = [kCIContextWorkingColorSpace: NSNull()]
            guard let eaglContext = EAGLContext(api: .openGLES2) else { fatalError("Failed to creat EAGLContext") }
            
            let ciContext = CIContext(eaglContext: eaglContext, options: options)
            //Get the final image from using the GPU
            //these will always be the 3 lines that are used
            guard let outputImage = filter.outputImage else { fatalError("Failed to get the output image from Filter.") }
            
            if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                
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



