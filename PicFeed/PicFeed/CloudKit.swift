//
//  CloudKit.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/27/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit
import CloudKit



typealias SuccessCompletion = (Bool) -> ()
typealias PostsCompletion = ([Post]?)->()

class CloudKit {
    //creating a CloudKit as a singletone
    static let shared = CloudKit()
    private init ( ){ }
    //creating a container to store later
    let container = CKContainer.default()
    
    var privateDatabase : CKDatabase {
        return container.privateCloudDatabase
    }
    func save(post: Post, completion: @escaping SuccessCompletion) {
        do {
            if let record = try Post.recordFor(post: post) {
                
                privateDatabase.save(record, completionHandler: { (record, error) in
                    
                    if error != nil {
                        completion(false)
                        return
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
    
    func getPosts(completion: @escaping PostsCompletion){
        
        let postQuery = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        
        self.privateDatabase.perform(postQuery, inZoneWith: nil) { (records, error) in
            
            if error != nil {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
            if let records = records {
                
                var posts = [Post]()
                
                for record in records {
                    
                    if let asset = record["image"] as? CKAsset{
                        
                        let path = asset.fileURL.path
                        
                        if let image = UIImage(contentsOfFile: path) {
                            
                            let fetchedPost = Post(image: image, date: record.creationDate!)
                            
                            posts.append(fetchedPost)
                        }
                    }
                }
                OperationQueue.main.addOperation {
                    completion(posts)
                }
            }
        }
    }
    
    
}
