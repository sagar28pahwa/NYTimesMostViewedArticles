//
//  NYTimesMostViewedArticleVC.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

extension UIViewController: UIViewControllerType {
    func push(vc: UIViewControllerType, animated: Bool) {
        if let vc = vc as? UIViewController {
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
}

class NYTimesMostViewedArticleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let cellNibName = "ViewedArticleCell"
    
    lazy var viewModel: NYTimesMostViewedArticleViewModel = {
        return NYTimesMostViewedArticleViewModel(api: ArticlesAPI(client: NetworkClient()))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
        fetchMostViewedArticles()
    }
    
    func configUI() {
        tableView.register(UINib(nibName: cellNibName, bundle: Bundle.init(for: ViewedArticleCell.self)), forCellReuseIdentifier: cellNibName)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = "ViewedArticleTableView"
        tableView.tableFooterView = UIView(frame: .zero)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    func fetchMostViewedArticles() {
        startShowingLoading()
        viewModel.fetchMostViewArticles { [weak self] (error) in
            self?.stopShowingLoading()
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                self?.present(alert, animated: true, completion: nil)
            }
            else {
                self?.tableView.reloadData()
            }
        }
    }
    
    func startShowingLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopShowingLoading() {
        activityIndicator.stopAnimating()
    }
}

extension NYTimesMostViewedArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNibName, for: indexPath) as! ViewedArticleCell
        cell.accessibilityLabel = "\(cellNibName)_\(indexPath.row)"
        cell.configUI(model: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showDetailScreen(index: indexPath.row, source: self)
    }
}

