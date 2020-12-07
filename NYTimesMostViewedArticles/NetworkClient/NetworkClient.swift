//
//  NetworkClient.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol NetworkClientType {
    func fetchResponse<T: Codable>(for request: URLRequest, completion: @escaping (T?, Error?)->())
}

enum Keys: String {
    case nyTimesKey = "yxPlqAEPWW3qKi0BgofuzzXeEbxkGfj4"
    case mockKey = "1234567890"
}

enum PeriodSection: Int {
    case day = 1
    case week = 7
    case month = 30
}

struct API {
    static let baseURL = "http://api.nytimes.com/"
    static let contentURL = "svc/mostpopular/v2/viewed"
        //"svc/mostpopular/v2/mostviewed/all-sections/"
}

enum NetworkClientError: Error {
    case unexpectedMime
    case dataMissing
    case failure
}

class NetworkClient: NetworkClientType {
    
    private let config = Config.shared
    
    func fetchResponse<T: Codable>(for request: URLRequest, completion: @escaping (T?, Error?)->()) {
        
        let task = config.urlSession().dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            else {
                guard let data = data else {
                    completion(nil, NetworkClientError.dataMissing)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completion(nil, NetworkClientError.failure)
                    return
                }
                guard let mime = response?.mimeType, mime == "application/json" else {
                    completion(nil, NetworkClientError.unexpectedMime)
                    return
                }
                do {
                    // make sure this JSON is in the format we expect
                     let response = try JSONDecoder().decode(T.self, from: data)
                     completion(response, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        })
        task.resume()
    }
}
