//
//  RestaurantCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/20.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    fileprivate let restaurantImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.image = #imageLiteral(resourceName: "vegan-healthy-food")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(restaurantImageView)

        restaurantImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        restaurantImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        restaurantImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        restaurantImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
