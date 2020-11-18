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
}

enum Keys: String {
    case nyTimesKey = "yxPlqAEPWW3qKi0BgofuzzXeEbxkGfj4"
}

enum PeriodSection: Int {
    case day = 1
    case week = 7
    case month = 30
}

typealias closure = ()

class NetworkClient: NetworkClientType {
    let session = URLSession.shared
    
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?)->()) {
        let string = "http://api.nytimes.com/svc/mostpopular/v2/viewed/\(period.rawValue).json?api-key=\(Keys.nyTimesKey.rawValue)"
        let url = URL(string: string)!

            //)!

        var request = URLRequest(url: url)
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
