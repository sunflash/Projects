//
//  String.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

// MARK: - Convenience string function

func newLine(_ count: Int = 1) -> String {
    return String(repeating: "\n", count: count)
}

func tab(_ count: Int = 1) -> String {
    return String(repeating: "\t", count: count)
}

func removeSubStrings(_ text: String, _ remove: [String]) -> String {
    var text = text
    remove.forEach {text = text.replacingOccurrences(of: $0, with: "")}
    return text
}

// swiftlint:disable identifier_name

func lowerCaseFirstLetter(_ string: String) -> String {
    var s = string
    let i = s.startIndex
    s.replaceSubrange(i...i, with: String(s[i]).lowercased())
    return s
}

func capitalizingFirstLetter(_ string: String) -> String {
    var s = string
    let i = s.startIndex
    s.replaceSubrange(i...i, with: String(s[i]).uppercased())
    return s
}
