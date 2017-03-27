//
//  CloudKit.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/27/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import Foundation
import CloudKit

class CloudKit {
    //creating a CloudKit as a singletone
    static let shared = CloudKit()
    //creating a container to store later
    let container = CKContainer.default()
    
    var privateDatabase : CKDatabase {
        return container.privateCloudDatabase
    }
}
