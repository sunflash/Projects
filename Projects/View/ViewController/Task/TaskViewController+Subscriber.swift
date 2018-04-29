//
//  TaskViewController+Subscriber.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import ReSwift

// MARK: - State

extension TaskViewController: StoreSubscriber {

    func newState(state: TaskListState) {

        guard let selectedTaskListId = state.selectedTaskList?.id, shouldUpdateTask == true else {return}
        getTasks(taskListId: selectedTaskListId)
        shouldUpdateTask = false
    }
}
