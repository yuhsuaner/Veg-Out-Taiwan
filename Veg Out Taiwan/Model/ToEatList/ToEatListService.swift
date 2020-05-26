//
//  ToEatListService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/26.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Firebase

struct ToEatListService {
    
    static let shared = ToEatListService()
    
    let toEatListRef = Database.database().reference().child("toEatList")
    
    func createWantToGoList(uid: String, wantToGo: WantToGo, completion: @escaping (DatabaseCompletion)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        toEatListRef.child(uid).child("want2Go").setValue(wantToGo)
        
    }
    
    func uploadTweet(uid: String, wantToGo: WantToGo, restaurant: Restaurant,
                     completion: @escaping(DatabaseCompletion)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
//        let values = [Restaurant(address: restaurant.address,
//                                 phone: restaurant.phone,
//                                 restaurantName: restaurant.restaurantName,
//                                 categories: <#T##[String]?#>,
//                                 coordinates: <#T##Coordinates#>,
//                                 imageURL: <#T##[String]#>, rating: <#T##String#>,
//                                 bussinessHours: <#T##[String]#>)] as [String: Any]
        
//        toEatListRef.child(uid).child("want2Go").updateChildValues(values, withCompletionBlock: completion)
    }
}
