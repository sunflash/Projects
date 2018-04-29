//
//  TaskListReducer.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

struct TaskListReducer {

    // MARK: - Task List Main Reducer

    static func mainReducer(action: Action, state: TaskListState?) -> TaskListState {

        var taskListState = state ?? TaskListState()

        switch action {
        case let selectedTaskListAction as SelectTaskListAction:
            taskListState.selectedTaskList = selectedTaskListAction.taskList
        default:
            break
        }
        return taskListState
    }
}
