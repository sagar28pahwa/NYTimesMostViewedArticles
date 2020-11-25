//
//  NYTimesMostViewedArticlesTests.swift
//  NYTimesMostViewedArticlesTests
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import XCTest
@testable import NYTimesMostViewedArticles

class NYTimesMostViewedArticlesTests: XCTestCase {

    var viewModel: NYTimesMostViewedArticleViewModel!
    var session: URLSession!
    var client = NetworkClientMock(response: nil)
    var api: ArticlesAPI!
    
    override func setUpWithError() throws {
        session = URLSession(configuration: URLSessionConfiguration.default)
        api = ArticlesAPI(client: client)
        viewModel = NYTimesMostViewedArticleViewModel(api: api)
    }
    
    override func tearDownWithError() throws {
        session = nil
        client.mockResponse = nil
        api = nil
        viewModel = nil
    }
    
    func testAPISuccess() {
        
        let url = api.url(period: .day)
        
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
        guard let urlPath = Bundle(for: NYTimesMostViewedArticlesTests.self).url(forResource: "MockArticles", withExtension: "json"), let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return
        }
        let promise = expectation(description: "Completion handler invoked")
        do {
            let decoder = JSONDecoder()
            let articleResult = try decoder.decode(Response.self, from: jsonData)
            
            XCTAssertEqual(articleResult.results?.first?.section, "U.S.")
            XCTAssertNotEqual(articleResult.results?.first?.publishedDate, "2018-06-06.")
            client.mockResponse = articleResult
            viewModel.fetchMostViewArticles { (error) in
               XCTAssertNil(error)
                if viewModel.articles.first?._id == 100000005964396 {
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
