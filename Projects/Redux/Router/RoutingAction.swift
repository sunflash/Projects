//
//  RoutingAction.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

enum AppTransitionStyle {

    case none

    case replaceRoot

    case push

    case modal

    case forcePush
}

struct RoutingAction: Action {

    // MARK: - StoryBoard

    let storyBoard: AppStoryBoard

    let destination: RoutingDestination

    let transitionStyle: AppTransitionStyle

    init(storyBoard: AppStoryBoard, destination: RoutingDestination, transitionStyle: AppTransitionStyle) {
        self.storyBoard = storyBoard
        self.destination = destination
        self.transitionStyle = transitionStyle
        self.viewControllerType = UIViewController.self
    }

    // MARK: - XIB

    let viewControllerType: UIViewController.Type

    init(_ type: UIViewController.Type, transitionStyle: AppTransitionStyle) {
        self.storyBoard = .none
        self.destination = .none
        self.transitionStyle = transitionStyle
        self.viewControllerType = type
    }

    // MARK: - Action handler

    var configuration: ((UIViewController) -> Void)?

    var completion: ((UIViewController) -> Void)?
}
