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
    let imageURL: [String]
    let rating: Double
    let commentText: String
}

struct Image {
    
    let postImage: UIImage
}

struct ImageService {
    
    static let shared = ImageService()
    
    func saveImage(image: Image, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let imageData = image.postImage.jpegData(compressionQuality: 1.0) else { return }
        let fileNmae = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("post_images").child(fileNmae)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            storageRef.downloadURL { (url, error) in
                
                guard let postImageUrl = url?.absoluteString else { return }
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    let value = ["profileImageUrl": postImageUrl]
                    
                    Database.database().reference().child("postImage").updateChildValues(value, withCompletionBlock: completion)
            }
        }
    }
}
