//
//  MockClass.swift
//  NYTimesMostViewedArticlesTests
//
//  Created by Sagar Pahwa on 18/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
@testable import NYTimesMostViewedArticles

enum MockErrors: Error {
    case noMockData
}

class NetworkClientMock: NetworkClientType {
    
    var mockResponse: Response?
    
    init(response: Response?) {
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
    
    func mockFailURL(period: PeriodSection) -> URL {
        let string = "\(API.baseURL)/\(API.contentURL)/\(period.rawValue).json?api-key=\(Keys.mockKey.rawValue)"
        return URL(string: string)!
    }
}
