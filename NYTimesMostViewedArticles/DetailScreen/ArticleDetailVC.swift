//
//  ArticleDetailVC.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class ArticleDetailVC: UIViewController, ArticleDetailView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var source: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    var viewModel: ArticleDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configUI()
    }

    func configUI() {
        self.titleLabel.text = self.viewModel.title()
        self.source.text = self.viewModel.source()
        self.date.text = self.viewModel.date()
    }
}
