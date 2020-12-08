//
//  ViewedArticle.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

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
