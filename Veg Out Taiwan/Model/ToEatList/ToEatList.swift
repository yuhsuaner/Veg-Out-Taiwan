//
//  ToEatList.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/25.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

struct WantToGo: Codable {
    
    let restaurant: [Restaurant]
}

struct MyFavorite: Codable {
    
    let restaurant: [Restaurant]
}

struct Other: Codable {
    
    let restaurant: [Restaurant]
}
