//
//  NetworkClient.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol NetworkClientType {
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?)->())
    
    func url(period: PeriodSection) -> URL
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


typealias closure = ()

extension NetworkClientType {
    func url(period: PeriodSection) -> URL {
        let string = "\(API.baseURL)/\(API.contentURL)/\(period.rawValue).json?api-key=\(Keys.nyTimesKey.rawValue)"
        return URL(string: string)!
    }
}

class NetworkClient: NetworkClientType {
    
    let session = URLSession.shared
    

    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?)->()) {

        var request = URLRequest(url: self.url(period: period))
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                // make sure this JSON is in the format we expect
                 let response = try JSONDecoder().decode(Response.self, from: data)
                 completion(response, nil)
                
            } catch let error {
                print("Failed to load: \(error.localizedDescription)")
                completion(nil, error)
            }
        })
        task.resume()
    }
}
