//
//  UIColor.swift
//  Projects
//
//  Created by Min Wu on 23/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    convenience init?(hex: String?) {

        guard let hexString = hex else {return nil}

        var color = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if color.hasPrefix("#") {
            color.remove(at: color.startIndex)
        }

        guard color.count == 6 else {return nil}

        var rgbValue: UInt32 = 0
        Scanner(string: color).scanHexInt32(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}
