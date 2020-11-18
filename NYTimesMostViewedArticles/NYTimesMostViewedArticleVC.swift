//
//  NYTimesMostViewedArticleVC.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 17/11/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

extension UIViewController: UIViewControllerType {
    func push(vc: UIViewControllerType, animated: Bool) {
        if let vc = vc as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
}

class NYTimesMostViewedArticleVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let cellNibName = "ViewedArticleCell"
    
    lazy var viewModel: NYTimesMostViewedArticleViewModel = {
        let networkClient = NetworkClient()
        return NYTimesMostViewedArticleViewModel(networkClient: networkClient)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configUI()
        self.fetchMostViewedArticles()
    }
    
    func configUI() {
        self.tableView.register(UINib(nibName: cellNibName, bundle: Bundle.init(for: ViewedArticleCell.self)), forCellReuseIdentifier: cellNibName)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func fetchMostViewedArticles() {
        self.viewModel.fetchMostViewArticles { [weak self] (error) in
            if let error = error {
                //present error
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true, completion: nil)
            }
            else {
                self?.tableView.reloadData()
            }
        }
    }
}

extension NYTimesMostViewedArticleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewedArticleCell", for: indexPath) as! ViewedArticleCell
        cell.configUI(model: self.viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.showDetailScreen(index: indexPath.row, source: self)
    }
}
