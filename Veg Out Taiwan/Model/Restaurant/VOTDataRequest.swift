//
//  VOTDataRequest.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

enum VOTDataRequest: VOTRequest {

    case restaurant

    case user
    
//    case comment
    case comment(commentID: String)
    
    case userComment(uid: String)
    
    var headers: [String: String] {

        switch self {

        case .restaurant, .user, .comment, .userComment: return [:]

        }
    }

    var body: Data? {

        switch self {

        case .restaurant, .user, .comment, .userComment: return nil
            
//        case .comment(let commentID, let restaurantName, let reating, let imageURL, let commentText):
//
//        let commentID = [
//            "restaurantName": restaurantName,
//            "reating": reating,
//            "imageURL": [imageURL],
//            "commentText": commentText
//        ] as [String: Any]
//
//        return try? JSONSerialization.data(withJSONObject: commentID, options: .prettyPrinted)

        }
    }

    var method: String {

        switch self {

        case .restaurant, .user, .comment, .userComment: return VOTHTTPMethod.GET.rawValue
            
//        case .comment: return VOTHTTPMethod.PUT.rawValue

        }
    }
    
    var endPoint: String {

        switch self {

        case .restaurant: return "/VOT_Restaurants.json"

        case .user: return "/users.json"
            
        case .comment(let commentID): return "/comments/\(commentID).json"
            
        case .userComment(let uid): return "/users/\(uid)/comments.json"
            
        }
    }

}
