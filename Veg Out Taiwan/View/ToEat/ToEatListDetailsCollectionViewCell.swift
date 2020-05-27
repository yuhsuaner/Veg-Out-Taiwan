//
//  ToEatListDetailsCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/27.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class ToEatListDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            cellImageView.image = image
        }
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "non_photo-3")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let restaurantName: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name: "jf-openhuninn-1.0", size: 20)
        title.textColor = .G1
        title.numberOfLines = 0
        return title
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [cellImageView, restaurantName])
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        cellImageView.anchor(width: self.frame.width, height: self.frame.width)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
