//
//  ProjectReducer.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift

struct ProjectReducer {

    // MARK: - Project Main Reducer

    static func mainReducer(action: Action, state: ProjectState?) -> ProjectState {

        var projectState = state ?? ProjectState()

        switch action {
        case let selectedProjectAction as SelectProjectAction:
            projectState.selectedProject = selectedProjectAction.project
        default:
            break
        }
        return projectState
    }
}
