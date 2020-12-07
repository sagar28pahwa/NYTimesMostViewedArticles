//
//  ViewedArticleCell.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ViewedArticleCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var byNameLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        self.configAccessibility()
    }
    
    func configUI(model: ArticleRepresentable) {
        titleLabel.text = model.title
        byNameLabel.text = model.author
        publishedDateLabel.text = model.date
        isAccessibilityElement = true
    }
    
    func configAccessibility() {
        self.titleLabel.isAccessibilityElement = true
        self.titleLabel.accessibilityIdentifier = "ViewArticleCellTitle"
        
        self.byNameLabel.isAccessibilityElement = true
        self.byNameLabel.accessibilityIdentifier = "ViewArticleCellSource"
        
        self.publishedDateLabel.isAccessibilityElement = true
        self.publishedDateLabel.accessibilityIdentifier = "ViewArticleCellPublishedDate"
    }
}
