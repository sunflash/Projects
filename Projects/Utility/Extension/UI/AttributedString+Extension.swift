//
//  AttributedString+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit

extension String {

    func attributedString(with font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: font]
        return NSAttributedString(string: self, attributes: attributes)
    }

    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

extension Collection where Element == (String, UIFont) {

    func attributedStrings() -> [NSAttributedString] {
        return self.map {$0.0.attributedString(with: $0.1)}
    }
}
