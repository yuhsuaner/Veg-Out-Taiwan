//
//  RestaurantService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import FirebaseDatabase

struct RestaurantService {
    
    static let shared = RestaurantService()

    var ref = Database.database().reference()
    
    func fetchRestaurant(completion: @escaping(Restaurants) -> Void) {
        
        ref.child("VOT_Restaurants").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let restaurants = Restaurants(dictionary: dictionary)
            
            completion(restaurants)
        }
    }
}
