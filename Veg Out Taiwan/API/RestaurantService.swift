//
//  RestaurantService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

class RestaurantService {
    
    static let baseURL = URL(string: "https://veg-out-taiwan-1584254182301.firebaseio.com/VOT_Restaurants.json")
    
//    static func restaurant(completion: @escaping ([Restaurants]?) -> Void) {
//        
//        guard let url = baseURL else {return}
//        let jsonD = JSONDecoder()
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            if error != nil && data == nil {
//                print(error?.localizedDescription ?? "No data")
//                
//                completion(nil)
//            }
//            do {
//                let searchResult = try jsonD.decode(Restaurants.self, from: data!)
//                
//                print(searchResult)
//                completionHandler(searchResult.results)
//                
//            } catch {
//                
//                completion(nil, false)
//            }
//        }
//        task.resume()
//    }
    
}
