//
//  Comment.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/8.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

struct Comment: Codable {
    
    private(set) var commentId: String = UUID().uuidString
    
    let restaurantName: String
    let imageURL: [String]
    let rating: Double
    let commentText: String
}
