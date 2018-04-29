//
//  NavigationBar+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func invisible(_ invisible: Bool) {
        if invisible == true {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
            self.backgroundColor = .clear
        } else {
            self.setBackgroundImage(nil, for: .default)
            self.shadowImage = nil
            self.isTranslucent = false
            self.backgroundColor = nil
        }
    }
}
