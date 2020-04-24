//
//  UserService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            guard let username = dictionary["userName"] as? String else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
//
//            print(user.fullName)
//            print(user.userNmae)
            completion(user)
        }
    }
}
