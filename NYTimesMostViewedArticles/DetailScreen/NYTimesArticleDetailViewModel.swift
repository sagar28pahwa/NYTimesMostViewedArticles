//
//  ArticleDetailViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol ArticleDetailView: UIViewControllerType {
    var viewModel: NYTimesArticleDetailViewModel! { get set }
    func configureUI()
}

class NYTimesArticleDetailViewModel {
    
    let article: ArticleRepresentable
    
    weak var view: ArticleDetailView?
    
    init(article: ArticleRepresentable) {
        self.article = article
    }
    
    var title: String? {
        return article.title
    }
    
    var source: String? {
        return article.author
    }
    
    var date: String? {
        return article.date
    }
    
    func viewDidLoad() {
        view?.configureUI()
    }
}
