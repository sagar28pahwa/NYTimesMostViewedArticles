//
//  ArticleDetailViewController.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, ArticleDetailView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var viewModel: ArticleDetailViewModel! {
        didSet {
            viewModel.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }

    func configureUI() {
        titleLabel.text = viewModel.title
        source.text = viewModel.source
        date.text = viewModel.date
        titleLabel.accessibilityIdentifier = "titleLabel"
        source.accessibilityIdentifier = "sourceLabel"
        date.accessibilityIdentifier = "dateLabel"
    }
}
