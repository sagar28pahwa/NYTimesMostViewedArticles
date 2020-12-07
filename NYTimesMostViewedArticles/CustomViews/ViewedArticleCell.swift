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
        configAccessibility()
    }
    
    func configUI(model: ArticleRepresentable) {
        titleLabel.text = model.title
        byNameLabel.text = model.author
        publishedDateLabel.text = model.date
        isAccessibilityElement = true
    }
    
    func configAccessibility() {
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityIdentifier = "ViewArticleCellTitle"
        
        byNameLabel.isAccessibilityElement = true
        byNameLabel.accessibilityIdentifier = "ViewArticleCellSource"
        
        publishedDateLabel.isAccessibilityElement = true
        publishedDateLabel.accessibilityIdentifier = "ViewArticleCellPublishedDate"
    }
}
