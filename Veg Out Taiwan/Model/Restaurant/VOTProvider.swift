//
//  VOTProvider.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

typealias RestaurantHanlder = (Result<[Restaurant]>) -> Void
typealias CommentHanlder = (Result<[Comment]>) -> Void

class VOTProvider {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func fetchRestaurant(completion: @escaping RestaurantHanlder) {
        
        HTTPClient.shared.request(
            VOTDataRequest.restaurant,
            completion: { [weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        let restaurantData = try strongSelf.decoder.decode(
                            [Restaurant].self,
                            from: data
                        )
                        
                        DispatchQueue.main.async {
                            
                            completion(Result.success(restaurantData))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                        
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    func postComment(completion: @escaping CommentHanlder) {
        
    }
    
}
