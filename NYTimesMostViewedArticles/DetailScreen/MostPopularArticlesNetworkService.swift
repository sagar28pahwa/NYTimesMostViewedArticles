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
        var urlComponent = URLComponents()
        urlComponent.scheme = API.scheme
        urlComponent.host = API.host
        urlComponent.path = "\(API.contentURL)/\(period.rawValue).json"
        urlComponent.queryItems = [URLQueryItem(name: "api-key", value: Keys.nyTimesKey.rawValue)]
        return urlComponent.url!
    }
}

class MostPopularArticlesNetworkService: MostPopularArticlesNetworkServiceType {
    
    private let client: NetworkClientType
    
    init(client: NetworkClientType) {
        self.client = client
    }
    
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (MostViewedArticleResponse?, Error?)->()) {
        var request = URLRequest(url: MostPopularArticlesNetworkService.url(period: period))
        request.httpMethod = URLRequest.HttpMethod.get.rawValue
        client.fetchResponse(for: request) { (response: MostViewedArticleResponse?, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}

extension URLRequest {
    enum HttpMethod: String {
        case get = "GET"
    }
}
