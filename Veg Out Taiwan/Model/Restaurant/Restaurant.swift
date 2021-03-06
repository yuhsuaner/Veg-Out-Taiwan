//
//  Restaurant.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/28.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation
import GoogleMaps

struct Restaurant: Codable {
    
    let address: String
    let phone: String
    var restaurantName: String
    var categories: [String]?
    let coordinates: Coordinates
    let imageURL: [String]
    let rating: String
    let bussinessHours: [String]
}

struct Coordinates: Codable {
    
    let latitude: Double
    let longitude: Double
}
