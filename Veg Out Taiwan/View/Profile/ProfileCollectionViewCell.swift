//
//  ProfileCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/8.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            cellImageView.image = image
        }
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Pic6")
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
