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
}

class ArticleDetailViewModel {
    
    let article: ArticleRepresentable
    
    init(article: ArticleRepresentable) {
        self.article = article
    }
    
    func title() -> String? {
        return article.title
    }
    
    func source() -> String? {
        return article.author
    }
    
    func date() -> String? {
        return article.date
    }
}
