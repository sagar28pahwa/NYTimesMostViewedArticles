//
//  ViewedArticle.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

public struct MostViewedArticleResponse: Codable {

    public var status: String?
    public var copyright: String?
    public var numResults: Int?
    public var results: [ViewedArticle]?

    public enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}

public struct ViewedArticle: Codable {
    public var title: String?
    public var publishedDate: String?
    public var source: String?


    public enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_date"
        case source

    }
}
