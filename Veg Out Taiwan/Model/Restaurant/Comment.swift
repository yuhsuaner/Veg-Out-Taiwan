//
//  Comment.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/8.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct Comment: Codable {
    
    private(set) var commentId: String = UUID().uuidString
    
    let restaurantName: String
    var imageURL: [String]
    let rating: Double
    let commentText: String
//    let timestamp: Date
    let user: User
    var likes: Int = 0
    var didLike: Bool?
    
}

struct ImageService {
    
    static let shared = ImageService()
    
    let storageRef = Storage.storage().reference().child("post_images")
    
    func saveImage(image: UIImage, completion: @escaping(Error?, String?) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        let imageReference = storageRef.child(UUID().uuidString + ".jpg" )
        
        imageReference.putData(imageData, metadata: nil) { (meta, error) in
            
            imageReference.downloadURL { (url, error) in
                
                if let error = error {
                    
                    completion(error, nil)
                    
                    return
                }
                
                guard let postImageUrl = url?.absoluteString else { return }
                    
                completion(nil, postImageUrl)
            }
        }
    }
}

struct UserComment: Codable {
    
    let restaurantName: String
    var imageURL: [String]
    let rating: Double
    let commentText: String
//    let timestamp: Date
}
