//
//  ViewedArticleCell.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ViewedArticleCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var byNameLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    
    func configUI(model: ArticleRepresentable) {
        self.titleLabel.text = model.title
        self.byNameLabel.text = model.author
        self.publishedDateLabel.text = model.date
    }
}
