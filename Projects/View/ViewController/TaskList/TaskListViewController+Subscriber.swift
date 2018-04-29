//
//  TaskListViewController+Subscriber.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import ReSwift

// MARK: - State

extension TaskListViewController: StoreSubscriber {

    func newState(state: ProjectState) {

        guard let selectedProjectId = state.selectedProject?.id, shouldUpdateTaskList == true else {return}
        getTaskLists(projectId: selectedProjectId)
        shouldUpdateTaskList = false
    }
}
