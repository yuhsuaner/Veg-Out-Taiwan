//
//  PhotoWallCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/20.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class PhotoWallCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
