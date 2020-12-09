//
//  NYTimesMostViewedArticleViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit

protocol MostViewedArticlesListView: AnyObject {
    func updateUI(error: Error?)
    func startShowingLoading()
    func stopShowingLoading()
    func showDetail(for article: ArticleRepresentable)
}

class NYTimesMostViewedArticlesViewModel {
    
    private let apiService: MostPopularArticlesNetworkServiceType
    
    private(set) var articles = [NYTimesViewedArticle]()
    
    weak var view: MostViewedArticlesListView?
    
    init(apiService: MostPopularArticlesNetworkServiceType) {
        self.apiService = apiService
    }
    
    func viewDidLoad(period: PeriodSection = .day) {
        view?.startShowingLoading()
        fetchMostViewArticles(period: period) { [weak self] (error) in
            self?.view?.updateUI(error: error)
            self?.view?.stopShowingLoading()
        }
    }
    
    func fetchMostViewArticles(period: PeriodSection, completion: @escaping (Error?)->()) {
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
    
    func didSelectArticle(at index: Int) {
        view?.showDetail(for: articles[index])
    }
}
