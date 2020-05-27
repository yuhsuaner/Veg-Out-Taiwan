//
//  UserService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import FirebaseAuth
import Firebase

struct UserService {
    
    static let shared = UserService()

    var ref = Database.database().reference()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let username = dictionary["userName"] as? String ?? ""
            
            let user = User(uid: uid, dictionary: dictionary)

            print("USER: +++\(username)+++")
            
            UserDefaults.standard.set(user.userName, forKey: "Username")
            UserDefaults.standard.set(user.profileImageUrl, forKey: "UserImage")
            UserDefaults.standard.set(user.email, forKey: "UserMail")
            UserDefaults.standard.set(user.uid, forKey: "UID")
            
            completion(user)
        }
    }
}
