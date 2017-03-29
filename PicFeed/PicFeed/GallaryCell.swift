//
//  GallaryCell.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/29/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

class GallaryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var post: Post! {
        didSet{
            self.imageView.image = post.image
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
}
