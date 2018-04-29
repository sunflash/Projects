//
//  RoutingReducer.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {

    var routingState = state ?? RoutingState()

    switch action {
    case let routingAction as RoutingAction:
        routingState.storyBoard = routingAction.storyBoard
        routingState.screen = routingAction.destination
        routingState.transitionStyle = routingAction.transitionStyle
        routingState.viewControllerType = routingAction.viewControllerType
        routingState.configuration = routingAction.configuration
        routingState.completion = routingAction.completion
    default:
        break
    }
    return routingState
}
