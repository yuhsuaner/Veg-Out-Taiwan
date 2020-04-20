//
//  ImageCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/14.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView! {
        didSet {
            postImage.layer.cornerRadius = 5
        }
    }
}
