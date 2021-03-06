//
//  VOTParser.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

struct VOTSuccessParser<T: Codable>: Codable {

    let data: T

    let paging: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case data
        
        case paging = "next_paging"
    }
}

struct VOTFailureParser: Codable {

    let errorMessage: String
}
