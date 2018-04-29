//
//  TaskList.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public struct TaskList: Mappable {

    public var id: String?

    public var status: TaskListStatusType?

    public var name: String?

    public var description: String?

    public var projectId: String?

    public var projectName: String?

    public var milestoneId: String?

    public var uncompletedCount: Int?

    public var position: Int?

    public var pinned: Bool?

    public var complete: Bool?

    public var `private`: Bool?

    public var isTemplate: Bool?

    enum CodingKeys: String, CodingKey {

        case id
        case status
        case name
        case description

        case projectId
        case projectName
        case milestoneId = "milestone-id"

        case uncompletedCount  = "uncompleted-count"
        case position

        case pinned
        case complete
        case `private`
        case isTemplate
    }

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}
