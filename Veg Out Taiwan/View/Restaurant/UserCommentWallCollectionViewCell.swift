//
//  UserCommentWallCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/13.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class UserCommentWallCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "non_photo-1")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellImageView)
        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
