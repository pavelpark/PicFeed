//
//  FilterCell.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/30/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filterLabel: UILabel!
    var filterName : FilterName!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil 
    }
}
