//
//  ArticleDetailVC.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, ArticleDetailView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var viewModel: ArticleDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
    }

    func configUI() {
        titleLabel.text = viewModel.title()
        source.text = viewModel.source()
        date.text = viewModel.date()
    }
}
