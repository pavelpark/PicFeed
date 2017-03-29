//
//  GallaryViewController.swift
//  PicFeed
//
//  Created by Pavel Parkhomey on 3/29/17.
//  Copyright © 2017 Pavel Parkhomey. All rights reserved.
//

import UIKit

class GallaryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var allPosts = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
    }

}

//MARK: UICollectionViewDataSorce Extension
extension GallaryViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
}
