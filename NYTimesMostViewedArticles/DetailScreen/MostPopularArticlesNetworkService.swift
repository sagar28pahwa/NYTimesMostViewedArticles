//
//  ArticleAPI.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol MostPopularArticlesNetworkServiceType {
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (MostViewedArticleResponse?, Error?)->())
}

extension MostPopularArticlesNetworkServiceType {
    static func url(period: PeriodSection) -> URL {
        let string = "\(API.baseURL)/\(API.contentURL)/\(period.rawValue).json?api-key=\(Keys.nyTimesKey.rawValue)"
        return URL(string: string)!
    }
}

class MostPopularArticlesNetworkService: MostPopularArticlesNetworkServiceType {
    
    private let client: NetworkClientType
    
    init(client: NetworkClientType) {
        self.client = client
    }
    
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (MostViewedArticleResponse?, Error?)->()) {
        var request = URLRequest(url: MostPopularArticlesNetworkService.url(period: period))
        request.httpMethod = "GET"
        client.fetchResponse(for: request) { (response: MostViewedArticleResponse?, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
