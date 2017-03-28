//
//  CloudKit.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/27/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import Foundation
import CloudKit


typealias PostCompletion = (Bool) -> ()

class CloudKit {
    //creating a CloudKit as a singletone
    static let shared = CloudKit()
    //creating a container to store later
    let container = CKContainer.default()
    
    var privateDatabase : CKDatabase {
        return container.privateCloudDatabase
    }
    func save(post: Post, completion: @escaping PostCompletion) {
        do {
            if let record = try Post.recordFor(post: post) {
                
                privateDatabase.save(record, completionHandler: { (record, error) in
                    
                    if error != nil {
                        completion(false)
                //the false is representing the bool
                    }
                    if let record = record {
                        print(record)
                        completion(true)
                    } else {
                        completion(false)
                        
                    }
                })
            }
        } catch {
            print(error)
        }
    }
}
