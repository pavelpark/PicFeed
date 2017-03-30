//
//  Post.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/28/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    let image: UIImage
    let date: Date
    //let location: String
    
    init(image: UIImage, date: Date) {
        self.image = image
        self.date = date
    }
}

enum PostError : Error {
    case writingImageToData
    case writingDataToDisk
}

extension Post {
    
    class func recordFor(post: Post) throws -> CKRecord? {
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.writingImageToData }
        
        do {
            try data.write(to: post.image.path)
            
            let asset = CKAsset(fileURL: post.image.path)
            
            let record = CKRecord(recordType: "Post")
            record.setValue(asset, forKey: "image")
            
            return record
            
        } catch {
            throw PostError.writingDataToDisk
        }
    }
    
}

