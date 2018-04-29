//
//  ProjectAPI.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public struct ProjectAPI {

    // MARK: - Database Configuration

}

extension ProjectAPI {

    // MARK: - Project methodes

    public static func getAllProjects(_ projectQuery: ProjectQuery? = nil,
                                      completion: @escaping (HTTPResults<[Project]>) -> Void) -> RequestCancellationToken? {

        return ProjectAction.getAllProjects(projectQuery, completion: completion)
    }
}

extension ProjectAPI {

    // MARK: - Task list methodes

    public static func getTaskLists(projectId: String,
                                    taskListQuery: TaskListQuery? = nil,
                                    completion: @escaping (HTTPResults<[TaskList]>) -> Void) -> RequestCancellationToken? {

        return TaskListAction.getTaskLists(projectId: projectId,
                                           taskListQuery: taskListQuery,
                                           completion: completion)
    }
}

extension ProjectAPI {

    // MARK: - Task methodes

    public static func getTasks(taskListId: String,
                                taskQuery: TaskQuery? = nil,
                                completion: @escaping (HTTPResults<[TaskItem]>) -> Void) -> RequestCancellationToken? {

        return TaskAction.getTasks(taskListId: taskListId,
                                   taskQuery: taskQuery,
                                   completion: completion)
    }

    public static func completeTask(taskId: Int64, completion: @escaping (HTTPResults<String>) -> Void) -> RequestCancellationToken? {

        return TaskAction.completeTask(taskId: taskId, completion: completion)
    }

    public static func uncompleteTask(taskId: Int64, completion: @escaping (HTTPResults<String>) -> Void) -> RequestCancellationToken? {

        return TaskAction.uncompleteTask(taskId: taskId, completion: completion)
    }
}
