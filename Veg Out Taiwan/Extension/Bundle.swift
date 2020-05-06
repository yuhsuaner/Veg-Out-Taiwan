//
//  Bundle.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

extension Bundle {
    // swiftlint:disable force_cast
    static func VOTValueForMapJSON(resource: String, json: String) -> URL? {
        
//        Bundle.main.url(forResource: "MapStyle_Orange", withExtension: "json")
        
        return Bundle.main.url(forResource: resource, withExtension: json)
    }
    
    static func VOTValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }

    static func STValueForInt32(key: String) -> Int32 {

        return Bundle.main.infoDictionary![key] as! Int32
    }
    // swiftlint:enable force_cast
}
