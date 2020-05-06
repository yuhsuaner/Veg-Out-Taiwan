//
//  Restaurant.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/28.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation
import Firebase

struct Restaurants: Codable {
    
    let address: String
    let phone: String
    let restaurantName: String
    var categories:  [String]?
    var coordinates: Coordinates?
    var imageUrl: String?
    let rating: Double
}

struct Coordinates: Codable {
    
    let latitude: Double
    let longitude: Double
}
