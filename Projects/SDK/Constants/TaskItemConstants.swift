//
//  TaskItemConstants.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public enum TaskPrivacyType: Int, Codable {

    case open = 0

    case `private` = 1

    case inherit = 2
}

public enum TaskStatus: String, Codable {

    case new

    case deleted

    case completed

    case reopened
}

public enum TaskPriority: String, Codable {

    case undefined = ""

    case low

    case medium

    case high
}

public enum TaskPredecessorType: String, Codable {

    case complete

    case start
}
