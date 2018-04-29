//
//  Constants.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public enum ProjectStatusFilterType: String {

    case `default`

    case all = "ALL"

    case active = "ACTIVE"

    case archived = "ARCHIVED"

    case current = "CURRENT"

    case late = "LATE"

    case completed = "COMPLETED"
}

public enum ProjectStatusType: String, Codable {

    case active

    case inactive
}

public enum ProjectSubStatusType: String, Codable {

    case current
}
