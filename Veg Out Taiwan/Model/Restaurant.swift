//
//  Restaurant.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/28.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation
import Firebase

struct Restaurants {
    
    let address: String
    let phone: String
    let restaurantName: String
    let categories: [String]
    var coordinates: Coordinates?
    let imageUrl: String
    let rating: Double

    init(dictionary: [String: AnyObject]) {
        
        self.address = dictionary["Address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.restaurantName = dictionary["RestaurantName"] as? String ?? ""
        self.categories = dictionary["categories"] as? [String] ?? [""]
        self.imageUrl = dictionary["image_url"] as? String ?? ""
        self.rating = dictionary["rating"] as? Double ?? 0
    }
}

struct Coordinates {
    
    let latitude: Double
    let longitude: Double
}
