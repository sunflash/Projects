//
//  CommonUI.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

struct CommonUI {

    static func configureSearchTextField(_ searchTextField: UITextField, placeholder: String) {

        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                   attributes: [.foregroundColor: ColourPaletteSecondary.blue,
                                                                                .font: AppFont.textFont(forTextStyle: .footnote)])
        searchTextField.layer.cornerRadius = 5
        searchTextField.textColor = .white
        searchTextField.font = AppFont.systemFont(forTextStyle: .body)
        searchTextField.backgroundColor = ColourPalettePrimary.blue
        searchTextField.textLeadingSpace(10)
    }

    static func counterLabel(_ count: Int?) -> UILabel? {

        guard let countNumber = count, countNumber > 0 else {return nil}

        let counterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        counterLabel.textAlignment = .center
        counterLabel.textColor = ColourPalettePrimary.blue
        counterLabel.font = AppFont.systemFont(forTextStyle: .footnote)
        counterLabel.text = "\(countNumber)"
        counterLabel.layer.borderColor = ColourPaletteSecondary.blue.cgColor
        counterLabel.layer.borderWidth = 1
        counterLabel.layer.cornerRadius = 4
        return counterLabel
    }
}
