//
//  NYTimesMostViewedArticleVC.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

class NYTimesMostViewedArticlesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    let cellNibName = "NYTimesMostViewedArticleCell"
    
    lazy var viewModel: NYTimesMostViewedArticlesViewModel = {
        var viewModel = NYTimesMostViewedArticlesViewModel(apiService: MostPopularArticlesNetworkService(client: NetworkClient()))
        viewModel.view = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        viewModel.viewDidLoad()
    }
    
    func configureUI() {
        tableView.register(UINib(nibName: cellNibName, bundle: Bundle.init(for: NYTimesMostViewedArticleCell.self)), forCellReuseIdentifier: cellNibName)
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = "ViewedArticleTableView"
        tableView.tableFooterView = UIView(frame: .zero)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showDetail(for article: ArticleRepresentable) {
        if let articleDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: NYTimesArticleDetailViewController.identifier) as? ArticleDetailView {
            articleDetailVC.viewModel = NYTimesArticleDetailViewModel(article: article)
            push(viewController: articleDetailVC, animated: true)
        }
    }
}

extension NYTimesMostViewedArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNibName, for: indexPath) as! NYTimesMostViewedArticleCell
        cell.accessibilityLabel = "\(cellNibName)_\(indexPath.row)"
        cell.configureUI(model: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectArticle(at: indexPath.row)
    }
}

extension NYTimesMostViewedArticlesViewController: MostViewedArticlesListView {
 
    func startShowingLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopShowingLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateUI(error: Error?) {
        if let error = error as? MockErrors {
            showAlert(message: error.localizedDescription)
        }
        else if let error = error {
            showAlert(message: error.localizedDescription)
        }
        else {
            tableView.reloadData()
        }
    }
}
