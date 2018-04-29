//
//  AppReducer.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        projectState: ProjectReducer.mainReducer(action: action, state: state?.projectState),
        taskListState: TaskListReducer.mainReducer(action: action, state: state?.taskListState)
    )
}

struct ReducerFormatter {

    static let dateFormatter: DateFormatter = DateFormatter()
}
