//
//  AuthService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct AuthCredentials {
    let email: String
    let username: String
    let fullname: String
    let password: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.username
        let fullName = credentials.fullname
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return }
        let fileNmae = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child(fileNmae)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            storageRef.downloadURL { (url, error) in
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let uid = authResult?.user.uid else { return }
                    
                    let value = ["email": email,
                                 "userName": userName,
                                 "fullName": fullName,
                                 "profileImageUrl": profileImageUrl]
                    
                    Database.database().reference().child("users").child(uid).updateChildValues(value, withCompletionBlock: completion)
                }
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
