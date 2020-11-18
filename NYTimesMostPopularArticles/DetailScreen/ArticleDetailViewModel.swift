//
//  ArticleDetailViewModel.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

class ArticleDetailViewModel {
    
    let article: ArticleRepresentable
    
    init(article: ArticleRepresentable) {
        self.article = article
    }
    
    func title() -> String? {
        return self.article.title
    }
    
    func source() -> String? {
        return self.article.author
    }
    
    func date() -> String? {
        return self.article.date
    }
}
