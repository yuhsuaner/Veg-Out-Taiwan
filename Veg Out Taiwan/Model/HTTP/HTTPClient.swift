//
//  HTTPClient.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/6.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Foundation

enum Result<T> {

    case success(T)

    case failure(Error)
}

enum VOTHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

enum VOTHTTPMethod: String {

    case GET

    case POST
}

enum VOTHTTPHeaderField: String {

    case contentType = "Content-Type"

    case auth = "Authorization"
}

enum VOTHTTPHeaderValue: String {

    case json = "application/json"
}

protocol VOTRequest {

    var headers: [String: String] { get }

    var body: Data? { get }

    var method: String { get }

    var endPoint: String { get }
}

extension VOTRequest {
    
    func makeRequest() -> URLRequest {

        let urlString = Bundle.STValueForString(key: VOTConstant.urlKey) + endPoint

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        request.httpBody = body

        request.httpMethod = method

        return request
    }
}

class HTTPClient {

    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()

    private init() { }

    func request(
        _ votRequest: VOTRequest,
        completion: @escaping (Result<Data>) -> Void
    ) {

        URLSession.shared.dataTask(
            with: votRequest.makeRequest(),
            completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(VOTHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(VOTHTTPClientError.serverError))

            default: return

                completion(Result.failure(VOTHTTPClientError.unexpectedError))
            }

        }).resume()
    }
}
