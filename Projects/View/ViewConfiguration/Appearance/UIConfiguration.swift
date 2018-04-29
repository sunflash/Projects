//
//  UIConfiguration.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

public struct UIConfiguration {

    static func loadUIConfig() {
        self.configureNavigationBar()
        self.configureIconFont()
        self.setupKeyboardManager()
        self.setupLoadingIndicator()
    }

    private static func configureIconFont() {
        UIFont.iconFontName = "feather"
        UIFont.iconFontDefaultColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    private static func configureNavigationBar() {
        UIApplication.shared.isStatusBarHidden = false
        let navBarAppearace = UINavigationBar.appearance()
        navBarAppearace.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navBarAppearace.barTintColor = BarColour.navigationBar
        navBarAppearace.isTranslucent = false
        navBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }

    private static func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    private static func setupLoadingIndicator() {
        LoadingIndicator.defaultMessage = NSLocalizedString("IndicatorLoading", comment: "Indicator")
        LoadingIndicator.messageFont = AppFont.textFont(forTextStyle: .subheadline, weight: .semiBold)
    }
}
