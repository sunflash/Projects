//
//  UIViewController+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func viewControllerIndex<T: UIViewController>(_ type: T.Type) -> Int {
        let controllers = [navigationController, presentingViewController, presentingViewController?.navigationController]
        let navController = controllers.compactMap {$0 as? UINavigationController}.first
        let viewControllerCount = navController?.viewControllers.compactMap {$0 as? T}.count ?? 0
        return max((viewControllerCount-1), 0)
    }
}
