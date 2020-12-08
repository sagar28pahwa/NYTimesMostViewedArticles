//
//  ViewedArticle.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

protocol ArticleRepresentable {
    var title: String? { get }
    var author: String? { get }
    var date: String? { get }
}

struct MostViewedArticleResponse: Codable {

    var status: String?
    var copyright: String?
    var numResults: Int?
    var results: [ViewedArticle]?

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

struct ViewedArticle: Codable {
    var title: String?
    var publishedDate: String?
    var source: String?
    var _id: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_date"
        case source
        case _id = "id"
    }
}

extension ViewedArticle: ArticleRepresentable {
    var author: String? {
        return source
    }
    
    var date: String? {
        return publishedDate
    }
}
