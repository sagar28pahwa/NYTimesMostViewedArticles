//
//  NYTimesMostViewedArticleViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit


class NYTimesMostViewedArticleViewModel {
    
    let api: MostPopularArticlesNetworkServiceType
    
    private(set) var articles = [ViewedArticle]()
    
    init(api: MostPopularArticlesNetworkServiceType) {
        self.api = api
    }
    
    func fetchMostViewArticles(completion: @escaping (Error?)->()) {
        api.getMostViewedArticles(period: .day) { [weak self] (response, error) in
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
