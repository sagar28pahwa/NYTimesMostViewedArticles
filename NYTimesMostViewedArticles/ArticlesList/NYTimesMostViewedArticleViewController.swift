//
//  NYTimesMostViewedArticleVC.swift
//  NYTimesMostViewedArticles
//
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import UIKit

protocol MostViewedArticlesListView: AnyObject {
    func updateUI(error: Error?)
    func startShowingLoading()
    func stopShowingLoading()
}

class NYTimesMostViewedArticleViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    let cellNibName = "NYTimesMostViewedArticleCell"
    
    lazy var viewModel: NYTimesMostViewedArticleViewModel = {
        return NYTimesMostViewedArticleViewModel(apiService: MostPopularArticlesNetworkService(client: NetworkClient()), view: self)
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
        self.present(alert, animated: true, completion: nil)
    }
}

extension NYTimesMostViewedArticleViewController: UITableViewDelegate, UITableViewDataSource {
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
        if let articleDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArticleDetailVC") as? ArticleDetailView {
            articleDetailVC.viewModel = NYTimesArticleDetailViewModel(article: viewModel.articles[indexPath.row])
            push(viewController: articleDetailVC, animated: true)
        }
    }
}

extension NYTimesMostViewedArticleViewController: MostViewedArticlesListView {
 
    func startShowingLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopShowingLoading() {
        activityIndicator.stopAnimating()
    }
    
    func updateUI(error: Error?) {
        if let error = error as? MockErrors {
            self.showAlert(message: error.localizedDescription)
        }
        else if let error = error {
            self.showAlert(message: error.localizedDescription)
        }
        else {
            self.tableView.reloadData()
        }
    }
}
