//
//  Project.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

public struct Project: Mappable {

    public var starred: Bool?

    public var status: ProjectStatusType?

    public var subStatus: ProjectSubStatusType?

    public var createdOn: Date?

    public var lastChangedOn: Date?

    public var id: String?

    public var name: String?

    public var description: String?

    public var startDate: String?

    public var endDate: String?

    public var logo: URL?

    public var category: ProjectCategory?

    public var company: ProjectCompany?

    public var tags: [TagStringID]?

    enum CodingKeys: String, CodingKey {
        case starred
        case status
        case subStatus
        case createdOn = "created-on"
        case lastChangedOn = "last-changed-on"
        case id
        case name
        case description
        case logo
        case startDate
        case endDate
        case category
        case company
        case tags
    }

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct ProjectCategory: Mappable {

    public var id: String?

    public var name: String?

    public var color: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct ProjectCompany: Mappable {

    public var id: String?

    public var name: String?

    public var isOwner: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isOwner = "is-owner"
    }

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}
