//
//  Tag.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

protocol Tag {

    var name: String? {get set}
    var color: String? {get set}
}

public struct TagStringID: Mappable, Tag {

    public var id: String? // swiftlint:disable:this identifier_name

    public var name: String?

    public var color: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct TagIntID: Mappable, Tag {

    public var id: Int64? // swiftlint:disable:this identifier_name

    public var name: String?

    public var color: String?

    public init() {}
    public var propertyValues: [String: Any] {return propertyValuesRaw}
}
