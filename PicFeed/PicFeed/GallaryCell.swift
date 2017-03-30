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
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var post: Post! {
        didSet{
            self.imageView.image = post.image
            let dateString = DateFormatter.localizedString(from: post.date,
                                                           dateStyle: .short,
                                                           timeStyle: .short)
            self.dateLabel.text = dateString
            
            
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
    
}
