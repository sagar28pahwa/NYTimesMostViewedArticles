//
//  ArticleDetailViewModel.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol UIViewControllerType: AnyObject {
    func push(vc: UIViewControllerType, animated: Bool)
}

protocol ArticleRepresentable {
    var title: String? { get }
    var author: String? { get }
    var date: String? { get }
}

protocol ArticleDetailView: UIViewControllerType {
    var viewModel: ArticleDetailViewModel! { get set }
    func configureUI()
}

class ArticleDetailViewModel {
    
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
        self.view?.configureUI()
    }
}
