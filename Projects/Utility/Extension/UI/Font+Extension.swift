//
//  Font+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    static var iconFontName = ""

    static var iconFontDefaultColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    static func iconFont(ofSize fontSize: CGFloat = 20) -> UIFont {

        let iconFont = UIFont(name: iconFontName, size: fontSize)
        return iconFont ?? UIFont.systemFont(ofSize: fontSize)
    }
}
