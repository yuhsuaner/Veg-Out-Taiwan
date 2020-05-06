//
//  RestaurantRequest.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

enum VOTDataRequest: VOTRequest {

    case restaurant

    case user

    var headers: [String: String] {

        switch self {

        case .restaurant, .user: return [:]

        }
    }

    var body: Data? {

        switch self {

        case .restaurant, .user: return nil

        }
    }

    var method: String {

        switch self {

        case .restaurant, .user: return VOTHTTPMethod.GET.rawValue

        }
    }

    var endPoint: String {

        switch self {

        case .restaurant: return "/VOT_Restaurants.json"

        case .user: return "/users.json"
            
        }
    }

}
