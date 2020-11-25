//
//  ArticleAPI.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol ArticlesAPIType {
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?)->())
}

extension ArticlesAPIType {
    func url(period: PeriodSection) -> URL {
        let string = "\(API.baseURL)/\(API.contentURL)/\(period.rawValue).json?api-key=\(Keys.nyTimesKey.rawValue)"
        return URL(string: string)!
    }
}

class ArticlesAPI: ArticlesAPIType {
    
    let client: NetworkClientType
    
    init(client: NetworkClientType) {
        self.client = client
    }
    
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?)->()) {
        var request = URLRequest(url: url(period: period))
        request.httpMethod = "GET"
        client.fetchResponse(for: request) { (response: Response?, error) in
            completion(response, error)
        }
    }
}
