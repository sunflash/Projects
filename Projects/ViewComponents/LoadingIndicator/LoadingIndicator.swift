//
//  LoadingIndicator.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//
import Foundation
import NVActivityIndicatorView

struct LoadingIndicator {

    public static var size: CGFloat = 50

    public static var indicatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    public static var textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    public static var backgroundColor = UIColor.black.withAlphaComponent(0.5)

    public static var defaultMessage = ""

    public static var messageFont = UIFont.systemFont(ofSize: 15)

    public static func startAnimating(message: String? = defaultMessage) {

        let activityData = ActivityData(size: CGSize(width: size, height: size),
                                        message: message,
                                        messageFont: messageFont,
                                        messageSpacing: 30,
                                        type: .ballScaleRippleMultiple,
                                        color: indicatorColor,
                                        backgroundColor: backgroundColor,
                                        textColor: textColor)

        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    public static func stopAnimating() {

        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
