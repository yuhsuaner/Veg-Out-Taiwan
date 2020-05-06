//
//  EndPointType.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

/*
 甚麼是 EndPoint？基本上它是一個 URLRequest，擁有所有構組元件如標頭 (Header)、查詢參數 (Query Parameters)、本體參數 (Body Parameters) 等 。
 */

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
