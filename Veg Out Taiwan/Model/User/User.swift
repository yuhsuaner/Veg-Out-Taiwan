//
//  User.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let email: String
    let userName: String
    let uid: String
    var profileImageUrl: String?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String
    }
    
    init(uid: String, username: String, userImage: String, email: String) {
        
        self.userName = username
        self.profileImageUrl = userImage
        self.uid = uid
        self.email = email
    }
}
