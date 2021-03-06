//
//  RestaurantCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/30.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var restaurantImage: UIImageView! {
        didSet {
            restaurantImage.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20).cgPath
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
}
