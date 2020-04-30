//
//  RestaurantService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RestaurantService {
    
    static let shared = RestaurantService()
    private init() {}
    
    var ref: DatabaseReference!
    
    func fetchRestaurant() {
        
        ref = Database.database().reference()
        ref.child("VOT_Restaurants").observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
        }
    }
}
