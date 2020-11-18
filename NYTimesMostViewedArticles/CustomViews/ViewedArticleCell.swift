//
//  ViewedArticleCell.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ViewedArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byNameLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI(model: ArticleRepresentable) {
        self.titleLabel.text = model.title
        self.byNameLabel.text = model.author
        self.publishedDateLabel.text = model.date
    }
}
