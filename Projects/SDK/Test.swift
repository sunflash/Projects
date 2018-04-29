//
//  Test.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

func testProject() {

    var query = ProjectQuery()
    query.projectStatusFilterType = .active

    _ = ProjectAPI.getAllProjects(query) {

        guard $0.isSuccess == true, let projects = $0.object else {
            return
        }

        projects.forEach {
            print($0.objectDescription)
        }
    }
}

func testTaskLists() {

    _ = ProjectAPI.getTaskLists(projectId: "301444") {

        guard $0.isSuccess == true, let taskLists = $0.object else {
            return
        }

        taskLists.forEach {
            print($0.objectDescription)
        }
    }
}

func testTasks() {

    _ = ProjectAPI.getTasks(taskListId: "958199") {

        guard $0.isSuccess == true, let tasks = $0.object else {
            return
        }

        for (index, task) in tasks.enumerated() {

            if index == 3 {break}
            print(task.objectDescription)
        }
    }
}
