//
//  NYTimesMostViewedArticlesUITests.swift
//  NYTimesMostViewedArticlesUITests
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import XCTest
@testable import NYTimesMostViewedArticles

class NYTimesMostViewedArticlesUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getIndexPath() -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    func getData() -> Data? {
        guard let urlPath = Bundle(for: NetworkClientMock.self).url(forResource: "MockArticles", withExtension: "json"),
              let jsonData = try? Data(contentsOf: urlPath) else {
            XCTFail("JSON file is missing")
            return nil
        }
        return jsonData
    }

    func testViewListAndDetail() throws {
        guard let data = getData() else {
            return
        }
        app.launchArguments = ["UI-TESTING"]
        app.launchEnvironment["MockResponse"] = String(data: data, encoding: .utf8)
        app.launch()
        
        let viewedArticleTableView = app.tables.matching(identifier: "ViewedArticleTableView")
        let indexPath = getIndexPath()
        XCTAssertEqual(viewedArticleTableView.cells.count, 2)
        let cell = viewedArticleTableView.cells.element(matching: .cell, identifier: "ViewedArticleCell_\(indexPath.row)")
        
        let title = "Trump Retreats on Separating Families, but Thousands May Remain Apart"
        let publishedBy = "The New York Times"
        let date = "2018-06-20"
        
        let cellTitleLabel = cell.staticTexts["ViewArticleCellTitle"]
        let cellSourceLabel = cell.staticTexts["ViewArticleCellSource"]
        let cellPublishDateLabel = cell.staticTexts["ViewArticleCellPublishedDate"]
        
        XCTAssertEqual(cellTitleLabel.label, title)
        XCTAssertEqual(cellSourceLabel.label, publishedBy)
        XCTAssertEqual(cellPublishDateLabel.label, date)
        cell.tap()
        
        let detailTitleLabel = app.staticTexts["titleLabel"]
        let detailSourceLabel = app.staticTexts["sourceLabel"]
        let detailDateLabel = app.staticTexts["dateLabel"]
        
        XCTAssertEqual(detailTitleLabel.label, title)
        XCTAssertEqual(detailSourceLabel.label, publishedBy)
        XCTAssertEqual(detailDateLabel.label, date)
    }
}
