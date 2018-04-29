//
//  Appearance.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

struct AppFont {

    private static let standardTextFontFamily = "Avenir Next"
    private static let standardTextRegularFontName = "AvenirNext-Regular"
    private static let standardTextRegularItalicFontName = "AvenirNext-Italic"
    private static let standardTextSemiBoldFontName = "AvenirNext-DemiBold"
    private static let standardTextSemiBoldItalicFontName = "AvenirNext-DemiBoldItalic"
    private static let customTextLayoutFontName = "SavoyeLetPlain"

    //  https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    //  Large (Default)
    //  Style             Weight     Point size
    //  Large Title       Regular     34pt
    //  Title 1           Regular     28pt
    //  Title 2           Regular     22pt
    //  Title 3           Regular     20pt
    //  Headline          Semi-Bold   17pt
    //  Body              Regular     17pt
    //  Callout           Regular     16pt
    //  Subhead           Regular     15pt
    //  Footnote          Regular     13pt
    //  Caption 1         Regular     12pt
    //  Caption 2         Regular     11pt

    //  @available(iOS 11.0, *)
    //  public static let largeTitle: UIFontTextStyle

    enum FontWeight {
        case regular
        case regularItalic
        case semiBold
        case semiBoldItalic
    }

    private static func maximumPointSize(forTextStyle textStyle: UIFontTextStyle) -> CGFloat { // swiftlint:disable:this cyclomatic_complexity
        if #available(iOS 11, *) {
            if textStyle == .largeTitle {
                return 34
            }
        }
        switch textStyle {
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .body:
            return 17
        case .callout:
            return 16
        case .subheadline:
            return 15
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            return 17
        }
    }

    private static func fontSize(_ textStyle: UIFontTextStyle) -> CGFloat {
        let maxSize = maximumPointSize(forTextStyle: textStyle)
        let preferredSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let pointSize = min(preferredSize, maxSize)
        return pointSize
    }

    static func textFont(forTextStyle textStyle: UIFontTextStyle, weight: FontWeight = .regular) -> UIFont {

        let weight = (textStyle == .headline) ? .semiBold : weight

        var textFontName = ""
        switch weight {
        case .regular:
            textFontName = standardTextRegularFontName
        case .regularItalic:
            textFontName = standardTextRegularItalicFontName
        case .semiBold:
            textFontName = standardTextSemiBoldFontName
        case .semiBoldItalic:
            textFontName = standardTextSemiBoldItalicFontName
        }

        let pointSize = fontSize(textStyle)

        var textFont = UIFont(name: textFontName, size: pointSize) ?? UIFont.systemFont(ofSize: pointSize)

        if #available(iOS 11, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            textFont = fontMetrics.scaledFont(for: textFont, maximumPointSize: pointSize)
        }
        return textFont
    }

    static func systemFont(forTextStyle textStyle: UIFontTextStyle, weight: UIFont.Weight = .regular) -> UIFont {

        let pointSize = fontSize(textStyle)
        var textFont = UIFont.systemFont(ofSize: pointSize, weight: weight)

        if #available(iOS 11, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            textFont = fontMetrics.scaledFont(for: textFont, maximumPointSize: pointSize)
        }
        return textFont
    }

    static func customTextLayoutFont(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        let systemFont = UIFont.preferredFont(forTextStyle: textStyle)
        let customTextLayoutFont = UIFont(name: customTextLayoutFontName, size: systemFont.pointSize)
        return customTextLayoutFont ?? systemFont
    }

    static func displayFontInfo() {
        let families = UIFont.familyNames
        families.sorted().forEach {
            print("\($0)")
            let names = UIFont.fontNames(forFamilyName: $0)
            print(names)
            print(String(repeating: "-", count: 100))
        }
    }
}
