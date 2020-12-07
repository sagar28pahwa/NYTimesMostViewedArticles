//
//  MockClass.swift
//  NYTimesMostViewedArticlesTests
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
@testable import NYTimesMostViewedArticles

enum MockErrors: Error {
    case noMockData
}

class NetworkClientMock {
    
    var mockResponse: Codable?
    
    init(response: Codable?) {
        self.mockResponse = response
    }
    
    func fetchResponse<T>(for request: URLRequest, completion: @escaping (T?, Error?) -> ()) where T : Codable {
        if let response = (mockResponse as? T) {
            completion(response, nil)
        }
        else {
            completion(nil, MockErrors.noMockData)
        }
    }
}
