//
//  RountingState.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

struct RoutingState: StateType {

    // MARK: - StoryBoard

    var storyBoard: AppStoryBoard = .main

    var screen: RoutingDestination = .project

    var transitionStyle: AppTransitionStyle = .none

    init() {}

    // MARK: - XIB

    var viewControllerType: UIViewController.Type = UIViewController.self

    // MARK: - Action handler

    var configuration: ((UIViewController) -> Void)?

    var completion: ((UIViewController) -> Void)?
}
