//
//  UITableView+Extension.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func deselectRow() {
        if let index = self.indexPathForSelectedRow {
            self.deselectRow(at: index, animated: true)
        }
    }
}
