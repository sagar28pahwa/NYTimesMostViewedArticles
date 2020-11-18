//
//  MockClass.swift
//  NYTimesMostViewedArticlesTests
//
//  Created by Sagar Pahwa on 18/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

enum MockErrors: Error {
    case noMockData
}

class NetworkClientMock: NetworkClientType {
    
    var response: Response?
    
    init(response: Response?) {
        self.response = response
    }
    
    func getMostViewedArticles(period: PeriodSection, completion: @escaping (Response?, Error?) -> ()) {
        if let response = response {
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
