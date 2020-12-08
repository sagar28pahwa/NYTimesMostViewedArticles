//
//  NYTimesMostViewedArticleViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit


class NYTimesMostViewedArticleViewModel {
    
    private let apiService: MostPopularArticlesNetworkServiceType
    
    private(set) var articles = [NYTimesViewedArticle]()
    
    init(apiService: MostPopularArticlesNetworkServiceType) {
        self.apiService = apiService
    }
    
    func fetchMostViewArticles(period: PeriodSection = .day, completion: @escaping (Error?)->()) {
        apiService.getMostViewedArticles(period: period) { [weak self] (response, error) in
            DispatchQueue.main.async {
             if let articleResults = response?.results {
                    self?.articles = articleResults
                    completion(nil)
             }
             else if let error = error {
                completion(error)
             }
           }
        }
    }
}
