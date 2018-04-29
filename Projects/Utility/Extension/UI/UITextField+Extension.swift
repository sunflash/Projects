//
//  UITextField+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func textLeadingSpace(_ width: CGFloat) {
        let leadingSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        leadingSpaceView.backgroundColor = .clear
        self.leftView = leadingSpaceView
        self.leftViewMode = .always
    }
}
