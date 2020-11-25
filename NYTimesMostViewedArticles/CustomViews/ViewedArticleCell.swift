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
        titleLabel.text = model.title
        byNameLabel.text = model.author
        publishedDateLabel.text = model.date
    }
}
