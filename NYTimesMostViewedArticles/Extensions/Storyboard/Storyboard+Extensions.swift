//
//  Storyboard+Extensions.swift
//  NYTimesMostViewedArticles
//
//  Created by Sagar Pahwa on 08/12/20.
//  Copyright © 2020 Sagar Pahwa. All rights reserved.
//

import Foundation
import UIKit.UIStoryboard

enum Storyboard: String {
    case main = "Main"
}

extension UIStoryboard {
    static func get(storyboard: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
    
    static func get<T: UIViewController>(viewController: T.Type, storyboard: Storyboard) -> T? {
        return self.get(storyboard: storyboard).instantiateViewController(identifier: viewController.identifier) as? T
    }
}
