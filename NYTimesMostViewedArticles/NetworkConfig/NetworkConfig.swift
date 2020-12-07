//
//  NetworkConfig.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

class Config {
    static let shared = Config.init()
    
    private init() {
    }
    
    func urlSession() -> URLSession {
        guard UITesting() else {
            return URLSession.shared
        }
    
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: sessionConfiguration)
    }
    
    private func UITesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
}

typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

class URLProtocolMock: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
            // Handle all types of requests
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Required to be implemented here. Just return what is passed
      return request
    }
    
    override func startLoading() {
        if let dataString = ProcessInfo.processInfo.environment["MockResponse"] {
            
            if let response = HTTPURLResponse(url: ArticlesAPI.url(period: .day), statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]) {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        self.client?.urlProtocol(self, didLoad: Data(dataString.utf8))
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
            // Required to be implemented. Do nothing here.
    }
}