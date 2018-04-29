//
//  AppState.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

struct AppState: StateType {

    // MARK: - Routing
    let routingState: RoutingState

    // MARK: - Project
    let projectState: ProjectState

    // MARK: - Task List
    let taskListState: TaskListState
}
