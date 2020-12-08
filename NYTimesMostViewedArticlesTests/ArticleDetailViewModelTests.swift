//
//  ArticleDetailViewModelTests.swift
//  NYTimesMostViewedArticlesTests
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import XCTest

class ArticleDetailViewModelTests: XCTestCase {
    
    var viewModel: ArticleDetailViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let article = getArticle() {
            viewModel = ArticleDetailViewModel(article: article)
        }
        else {
            XCTFail()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func getArticle() -> ArticleRepresentable? {
        guard let urlPath = Bundle(for: NYTimesMostViewedArticlesTests.self).url(forResource: "MockArticles", withExtension: "json"), let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return nil
        }
        do {
            return try JSONDecoder().decode(Response.self, from: jsonData).results?.first
        }
        catch {
            return nil
        }
    }
    
    func testViewDetail() {
        XCTAssertEqual(viewModel.source, "The New York Times")
        XCTAssertEqual(viewModel.title, "Trump Retreats on Separating Families, but Thousands May Remain Apart")
        XCTAssertEqual(viewModel.date, "2018-06-20")
    }

}
