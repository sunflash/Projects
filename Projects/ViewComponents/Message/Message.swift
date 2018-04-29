//
//  Message.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit
import SwiftMessages

class Message {

    private static let messageFont = AppFont.textFont(forTextStyle: .body)
    private static let backgroundColor = ColourPalettePrimary.darkRed
    private static let showErrorViewButton = false

    static func showErrorMessage(text: String, second: TimeInterval = 3, forever: Bool = false, completion: @escaping (Bool) -> Void = { _ in }) {

        let errorView = (try? SwiftMessages.viewFromNib()) ?? MessageView()
        errorView.configureTheme(backgroundColor: backgroundColor, foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), iconImage: nil, iconText: nil)
        errorView.bodyLabel?.font = messageFont
        errorView.bodyLabel?.text = text

        errorView.button?.isHidden = !showErrorViewButton

        if showErrorViewButton {
            errorView.button?.setImage(Icon.errorSubtle.image, for: .normal)
            errorView.button?.setTitle(nil, for: .normal)
            errorView.button?.backgroundColor = UIColor.clear
            errorView.button?.tintColor = UIColor.white
            errorView.buttonTapHandler = { _ in
                SwiftMessages.hide()
                completion(true)
            }
        }

        errorView.iconImageView?.isHidden = true
        errorView.titleLabel?.isHidden = true

        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        statusConfig.duration = (forever == false) ? .seconds(seconds: second) : .forever
        statusConfig.presentationStyle = .top

        SwiftMessages.show(config: statusConfig, view: errorView)
        completion(true)
    }
}
