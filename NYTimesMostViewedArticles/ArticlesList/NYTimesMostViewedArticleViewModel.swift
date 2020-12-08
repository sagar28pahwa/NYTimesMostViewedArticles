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
    
    private weak var view: MostViewedArticlesListView?
    
    init(apiService: MostPopularArticlesNetworkServiceType, view: MostViewedArticlesListView) {
        self.apiService = apiService
        self.view = view
    }
    
    func viewDidLoad(period: PeriodSection = .day) {
        self.view?.startShowingLoading()
        self.fetchMostViewArticles(period: period) { [weak self] (error) in
            self?.view?.stopShowingLoading()
            self?.view?.updateUI(error: error)
        }
    }
    
    private func fetchMostViewArticles(period: PeriodSection, completion: @escaping (Error?)->()) {
        apiService.getMostViewedArticles(period: period) { [weak self] (response, error) in
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
