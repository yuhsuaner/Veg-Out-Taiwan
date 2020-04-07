//
//  RestaurantCollectionViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/30.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var numberOfStarLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
