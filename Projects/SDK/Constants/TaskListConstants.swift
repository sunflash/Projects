//
//  TaskListConstants.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public enum TaskListStatusFilterType: String {

    case `default`

    case all

    case active

    case completed
}

public enum TaskListStatusType: String, Codable {

    case new

    case reopened
}
