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
//    var restaurant: [Restaurant]? = [] {
//        didSet { configure() }
//    }
//
//    let votProvider = VOTProvider()
    
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
        
//        fetchRestaurant()
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
    
    // MARK: - Helper
    
//    func fetchRestaurant() {
//
//        votProvider.fetchRestaurant(completion: { [weak self] result in
//
//            switch result {
//
//            case .success(let restaurants):
//
//                self?.restaurant = restaurants
//                print(result)
//
//            case .failure:
//
//                VOTProgressHUD.showFailure(text: "讀取資料失敗！")
//            }
//        })
//    }
    
//    func configure() {
//        guard let restaurant = restaurant else { return }
//
//        restaurantNameLabel.text = restaurant.restaurantName
//        restaurantImage.loadImage(restaurant.imageUrl, placeHolder: #imageLiteral(resourceName: "Pic4"))
//    }
    
}
