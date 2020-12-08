//
//  NYTimesMostViewedArticlesTests.swift
//  NYTimesMostViewedArticlesTests
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import XCTest
@testable import NYTimesMostViewedArticles

class NYTimesMostViewedArticlesTests: XCTestCase {

    var viewModel: NYTimesMostViewedArticleViewModel!
    var session: URLSession!
    var client = NetworkClientMock(response: nil)
    var apiService: MostPopularArticlesNetworkServiceType!
    
    override func setUpWithError() throws {
        session = URLSession(configuration: URLSessionConfiguration.default)
        apiService = MostPopularArticlesNetworkService(client: client)
        viewModel = NYTimesMostViewedArticleViewModel(apiService: apiService)
    }
    
    override func tearDownWithError() throws {
        session = nil
        client.mockResponse = nil
        apiService = nil
        viewModel = nil
    }
    
    func testAPISuccess() {
        
        let url = MostPopularArticlesNetworkService.url(period: .day)
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAPIFail() {
        
        let url = client.mockFailURL(period: .day)
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 401)
    }
    
    func testClientMockSuccess() {
        guard let urlPath = Bundle(for: NYTimesMostViewedArticlesTests.self).url(forResource: "NYTimesMostViewedMockArticles", withExtension: "json"), let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return
        }
        let promise = expectation(description: "Completion handler invoked")
        do {
            let decoder = JSONDecoder()
            let articleResult = try decoder.decode(MostViewedArticleResponse.self, from: jsonData)
            
            XCTAssertNotEqual(articleResult.results?.first?.publishedDate, "2018-06-06.")
            client.mockResponse = articleResult
            viewModel.fetchMostViewArticles { (error) in
               XCTAssertNil(error)
                if self.viewModel.articles.first?._id == 100000005964396 {
                    promise.fulfill()
                }
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testClientError() {
        viewModel.fetchMostViewArticles { (error) in
            XCTAssertNotNil(error as? MockErrors)
        }
    }
}

extension NetworkClientMock: NetworkClientType {
    
    func mockFailURL(period: PeriodSection) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = API.scheme
        urlComponent.host = API.host
        urlComponent.path = "\(API.contentURL)/\(period.rawValue).json"
        urlComponent.queryItems = [URLQueryItem(name: "api-key", value: NYTimesKeys.mockKey.rawValue)]
        return urlComponent.url!
    }
}

