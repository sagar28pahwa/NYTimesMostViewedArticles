//
//  UIViewController+Extensions.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 08/12/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit.UIViewController

protocol UIViewControllerType: AnyObject {
    func push(viewController: UIViewControllerType, animated: Bool)
}

extension UIViewController: UIViewControllerType {
    func push(viewController: UIViewControllerType, animated: Bool) {
        if let viewController = viewController as? UIViewController {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}
