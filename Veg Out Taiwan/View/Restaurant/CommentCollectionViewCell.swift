//
//  CommentCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

protocol CategoryRowDelegate: class {
    func cellTapped()
}

class CommentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoFromCommentImage: UIImageView!
    
    @IBOutlet weak var ratingFromCommentLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
