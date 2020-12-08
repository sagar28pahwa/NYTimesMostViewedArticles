//
//  ViewedArticleCell.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class NYTimesMostViewedArticleCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var byNameLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        configureAccessibility()
    }
    
    func configureUI(model: ArticleRepresentable) {
        titleLabel.text = model.title
        byNameLabel.text = model.author
        publishedDateLabel.text = model.date
    }
    
    func configureAccessibility() {
        isAccessibilityElement = true
        titleLabel.accessibilityIdentifier = "ViewArticleCellTitle"
        byNameLabel.accessibilityIdentifier = "ViewArticleCellSource"
        publishedDateLabel.accessibilityIdentifier = "ViewArticleCellPublishedDate"
    }
}
