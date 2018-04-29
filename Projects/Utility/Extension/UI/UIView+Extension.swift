//
//  UIView+Extension.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // MARK: - Load nib from string

    func loadView(fromNib nib: String) -> UIView {
        return (Bundle(for: type(of: self)).loadNibNamed(nib, owner: self, options: nil)?.first as? UIView) ?? UIView()
    }

    func loadContentView() -> UIView {
        let nibName = type(of: self).description().components(separatedBy: ".").last ?? ""
        let contentView = loadView(fromNib: nibName)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": contentView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
        return contentView
    }
}
