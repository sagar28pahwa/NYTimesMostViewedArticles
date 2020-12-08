//
//  NYTimesMostViewedArticleVC.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

extension UIViewController: UIViewControllerType {
    func push(viewController: UIViewControllerType, animated: Bool) {
        if let viewController = viewController as? UIViewController {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}

class NYTimesMostViewedArticleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let cellNibName = "ViewedArticleCell"
    
    lazy var viewModel: NYTimesMostViewedArticleViewModel = {
        return NYTimesMostViewedArticleViewModel(api: MostPopularArticlesNetworkService(client: NetworkClient()))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        fetchMostViewedArticles()
    }
    
    func configureUI() {
        tableView.register(UINib(nibName: cellNibName, bundle: Bundle.init(for: ViewedArticleCell.self)), forCellReuseIdentifier: cellNibName)
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
            if let error = error as? MockErrors {
                self?.showAlert(message: error.localizedDescription)
            }
            else if let error = error {
                self?.showAlert(message: error.localizedDescription)
            }
            else {
                self?.tableView.reloadData()
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
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
        cell.configureUI(model: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let articleDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArticleDetailVC") as? ArticleDetailView {
            articleDetailVC.viewModel = ArticleDetailViewModel(article: viewModel.articles[indexPath.row])
            push(viewController: articleDetailVC, animated: true)
        }
    }
}

