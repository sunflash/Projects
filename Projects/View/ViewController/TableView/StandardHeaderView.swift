//
//  StandardHeaderView.swift
//  Projects
//
//  Created by Min Wu on 23/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

class StandardHeaderView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var icon: UILabel!
    @IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var iconToLabelSpace: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    // MARK: - view

    private func configureView() {
        let contentView = loadContentView()
        self.icon.text = nil
        self.icon.textColor = ColourPalettePrimary.blue
        self.icon.font = UIFont.iconFont(ofSize: 26)
        self.nameLabel.text = nil
        self.nameLabel.font = AppFont.textFont(forTextStyle: .body, weight: .semiBold)
        self.nameLabel.textColor = ColourPalettePrimary.blue
        contentView.backgroundColor = ColourPalettePrimary.lightBlue
    }

    func configureHeader(_ name: String, icon: String? = nil) {
        self.nameLabel.text = name
        self.iconWidthConstraint.constant = (icon == nil) ? 0 : 28
        self.iconToLabelSpace.constant = (icon == nil) ? 0 : 10
        self.icon.isHidden = (icon == nil)
        self.icon.text = icon
    }
}
