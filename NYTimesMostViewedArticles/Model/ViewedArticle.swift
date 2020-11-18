//
//  ViewedArticle.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

public struct Response: Codable {

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

    public var url: String?
    public var adxKeywords: String?
    public var column: String?
    public var section: String?
    public var byline: String?
    public var type: String?
    public var title: String?
    public var abstract: String?
    public var publishedDate: String?
    public var source: String?
    public var _id: Int?
    public var assetId: Int?
    public var views: Int?
    public var desFacet: [String]?
    public var orgFacet: [String]?
    public var perFacet: [String]?
    public var geoFacet: [String]?
    public var media: [Media]?
    public var uri: String?

    public enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column
        case section
        case byline
        case type
        case title
        case abstract
        case publishedDate = "published_date"
        case source
        case _id = "id"
        case assetId = "asset_id"
        case views
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case uri
    }
}

public struct Media: Codable {

    public var type: String?
    public var subtype: String?
    public var caption: String?
    public var copyright: String?
    public var approvedForSyndication: Bool?
    public var mediaMetadata: [MediaMetadata]?

    public enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try? container.decode(String.self, forKey: .type)
        self.subtype = try? container.decode(String.self, forKey: .subtype)
        self.caption = try? container.decode(String.self, forKey: .caption)
        self.copyright = try? container.decode(String.self, forKey: .copyright)
        if let approvedForSyndication = try? container.decode(Bool.self, forKey: .approvedForSyndication) {
            self.approvedForSyndication = approvedForSyndication
        }
        if let approvedForSyndication = try? container.decode(Int.self, forKey: .approvedForSyndication) {
            self.approvedForSyndication = approvedForSyndication == 0 ? false: true
        }
        self.mediaMetadata = try? container.decode([MediaMetadata].self, forKey: .mediaMetadata)
    }
}

public struct MediaMetadata: Codable {
    public var url: String?
    public var format: String?
    public var height: Int?
    public var width: Int?
}
