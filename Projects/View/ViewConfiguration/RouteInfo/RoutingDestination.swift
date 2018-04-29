//
//  RoutingDestination.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit

enum AppStoryBoard: String {

    // Xib
    case none

    // Main flow
    case main = "Main"
}

extension AppStoryBoard {
    func storyBoard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

enum RoutingDestination: String {

    // Xib
    case none

    // Project
    case project = "ProjectViewController"

    // Task List
    case taskList = "TaskListViewController"

    // Task
    case task = "TaskViewController"
}
