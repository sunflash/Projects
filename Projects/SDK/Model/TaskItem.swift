//
//  TaskItem.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public struct TaskItem: Mappable {

    // Status
    public var id: Int64?

    public var `private`: TaskPrivacyType?

    public var status: TaskStatus?

    public var priority: TaskPriority?

    public var completed: Bool?

    public var progress: Int?

    // Content
    public var description: String?

    public var content: String?

    public var estimatedMinutes: Int?

    public var timeIsLogged: String?

    public var parentTaskId: String?

    public var hasDependencies: Int?

    public var hasPredecessors: Int?

    public var boardColumn: TaskBoardColumn?

    public var predecessors: [TaskPredecessors]?

    public var parentTask: ParentTask?

    public var tags: [TagIntID]?

    // Date
    public var startDate: String?

    public var dueDateBase: String?

    public var dueDate: String?

    public var createdOn: Date?

    public var lastChangedOn: Date?

    // Order
    public var order: Int64?

    public var position: Int64?

    // Count
    public var commentsCount: Int?

    public var attachmentsCount: Int?

    // Relation
    public var projectId: Int64?

    public var projectName: String?

    public var todoListId: Int64?

    public var todoListName: String?

    public var companyId: Int64?

    public var companyName: String?

    public var creatorId: Int64?

    public var creatorFirstName: String?

    public var creatorLastName: String?

    public var creatorAvatarUrl: URL?

    public var lockdownId: String?

    public var tasklistLockDownId: String?

    // Setting
    public var canComplete: Bool?

    public var canEdit: Bool?

    public var canLogTime: Bool?

    public var hasReminders: Bool?

    public var hasUnreadComments: Bool?

    public var hasTickets: Bool?

    public var viewEstimatedTime: Bool?

    public var harvestEnabled: Bool?

    public var taskListPrivate: Bool?

    public var taskListIsTemplate: Bool?

    // Responsible
    public var responsiblePartyIds: String?

    public var responsiblePartyId: String?

    public var responsiblePartyNames: String?

    public var responsiblePartyType: String?

    public var responsiblePartyFirstName: String?

    public var responsiblePartyLastName: String?

    public var responsiblePartySummary: String?

    // Follow
    public var commentFollowerIds: String?

    public var commentFollowerSummary: String?

    public var changeFollowerIds: String?

    public var changeFollowerSummary: String?

    public var userFollowingComments: Bool?

    public var userFollowingChanges: Bool?

    public var dlm: Int?

    enum CodingKeys: String, CodingKey {

        case id
        case `private`
        case status
        case priority
        case completed
        case progress

        case description
        case content
        case estimatedMinutes = "estimated-minutes"
        case timeIsLogged
        case parentTaskId
        case hasDependencies = "has-dependencies"
        case hasPredecessors = "has-predecessors"

        case boardColumn
        case predecessors
        case parentTask = "parent-task"
        case tags

        case startDate = "start-date"
        case dueDateBase = "due-date-base"
        case dueDate = "due-date"
        case createdOn = "created-on"
        case lastChangedOn = "last-changed-on"

        case order
        case position

        case commentsCount = "comments-count"
        case attachmentsCount = "attachments-count"

        case projectId = "project-id"
        case projectName = "project-name"
        case todoListId = "todo-list-id"
        case todoListName = "todo-list-name"
        case companyId = "company-id"
        case companyName = "company-name"
        case creatorId = "creator-id"
        case creatorFirstName = "creator-firstname"
        case creatorLastName = "creator-lastname"
        case creatorAvatarUrl = "creator-avatar-url"
        case lockdownId
        case tasklistLockDownId = "tasklist-lockdownId"

        case canComplete
        case canEdit
        case canLogTime
        case hasReminders = "has-reminders"
        case hasUnreadComments = "has-unread-comments"
        case hasTickets
        case viewEstimatedTime
        case harvestEnabled = "harvest-enabled"
        case taskListPrivate = "tasklist-private"
        case taskListIsTemplate = "tasklist-isTemplate"

        case responsiblePartyIds = "responsible-party-ids"
        case responsiblePartyId = "responsible-party-id"
        case responsiblePartyNames = "responsible-party-names"
        case responsiblePartyType  = "responsible-party-type"
        case responsiblePartyFirstName = "responsible-party-firstname"
        case responsiblePartyLastName = "responsible-party-lastname"
        case responsiblePartySummary = "responsible-party-summary"

        case commentFollowerSummary
        case changeFollowerSummary
        case commentFollowerIds
        case changeFollowerIds
        case userFollowingComments
        case userFollowingChanges
        case dlm = "DLM"
    }

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct TaskBoardColumn: Mappable {

    public var id: Int?

    public var name: String?

    public var color: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct TaskPredecessors: Mappable {

    public var id: Int?

    public var type: TaskPredecessorType?

    public var name: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct ParentTask: Mappable {

    public var id: String?

    public var content: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}
