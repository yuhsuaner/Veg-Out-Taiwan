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
}
