//
//  User.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

struct User {
    
    let fullName: String
    let email: String
    let userNmae: String
    let uid: String
    var profileImageUrl: URL?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.userNmae = dictionary["userNmae"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"]  as? String {
            
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
        
    }
}
