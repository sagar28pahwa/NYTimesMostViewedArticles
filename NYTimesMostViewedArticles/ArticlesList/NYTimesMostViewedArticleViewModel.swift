//
//  NYTimesMostViewedArticleViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit

extension ViewedArticle: ArticleRepresentable {
    var author: String? {
        return source
    }
    
    var date: String? {
        return publishedDate
    }
}


class NYTimesMostViewedArticleViewModel {
    
    let api: ArticlesAPIType
    
    private(set) var articles = [ViewedArticle]()
    
    init(api: ArticlesAPIType) {
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
    
    func showDetailScreen(index: Int, source: UIViewControllerType) {
        if let articleDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArticleDetailVC") as? ArticleDetailView {
            articleDetailVC.viewModel = ArticleDetailViewModel(article: articles[index])
            source.push(vc: articleDetailVC, animated: true)
        }
    }
}
