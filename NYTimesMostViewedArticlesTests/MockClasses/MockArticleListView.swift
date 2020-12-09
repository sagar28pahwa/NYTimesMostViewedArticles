//
//  MockArticleListView.swift
//  NYTimesMostViewedArticlesTests
//
//  Created by Sagar Pahwa on 08/12/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation

enum LoaderState {
    case notInitiated
    case showingLoader
    case loaderStopped
}

class MockArticleListView: MostViewedArticlesListView {
    
    private(set) var loaderState = LoaderState.notInitiated
    private(set) var articleSelected: ArticleRepresentable?
    
    func updateUI(error: Error?) {
    }
    
    func startShowingLoading() {
        self.loaderState = .showingLoader
    }
    
    func stopShowingLoading() {
        self.loaderState = .loaderStopped
    }
    
    func showDetail(for article: ArticleRepresentable) {
        self.articleSelected = article
    }
}
