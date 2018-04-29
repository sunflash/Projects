//
//  TaskListAction.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

struct TaskLists: Mappable {
    var tasklists: [TaskList]?
    init() {}
    var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct TaskListQuery {

    public var taskListStatusFilterType: TaskListStatusFilterType = .default
}

struct TaskListAction: Log {

    private static let taskListsPath = "projects/%@/tasklists.json"

    private static let jsonResponse: JSONResponse = {
        let response = JSONResponse()
        response.useISO8601 = true
        return response
    }()

    static func getTaskLists(projectId: String,
                             taskListQuery: TaskListQuery?,
                             partialData: PartilaData<TaskList> = PartilaData(),
                             completion: @escaping (HTTPResults<[TaskList]>) -> Void) -> RequestCancellationToken? {

        var token: RequestCancellationToken? = partialData.cancellationToken

        GCD.userInitiated.queue.async {

            let getTaskList: (String, [URLQueryItem]) -> Void = { path, queries in

                // Combine task lists with pagination
                let transformation: ([TaskList]?) -> [TaskList]? = {
                    if let currentTaskLists = $0 {
                        return partialData.partialResults + currentTaskLists
                    } else {
                        return $0
                    }
                }

                // Success action
                let successAction: (HTTPResults<[TaskList]>) -> Void = {
                    if let nextPageQueries = APIService.isNextPage(path: path, queries: queries, headers: $0.headers), let taskLists = $0.object {

                        let data = PartilaData(nextPageQueries: nextPageQueries, partialResults: taskLists, cancellationToken: token)

                        _ = getTaskLists(projectId: projectId,
                                         taskListQuery: taskListQuery,
                                         partialData: data,
                                         completion: completion)
                    } else {
                        completion($0)
                    }
                }

                // Get task lists request
                let requestPath = ((queries.isEmpty == false) ? HTTPRequest.pathWithQuery(path: path, queryItems: queries) : path) ?? path
                var request = HTTPRequest(path: requestPath)
                request.expectedResponseContentType = .JSON

                token = ProjectsConfig.client.request(request: request, success: { response in

                    // Success
                    jsonResponse.decodeSuccessResponse(response, from: TaskLists.self, to: [TaskList].self, transform: {
                        return transformation($0.tasklists)
                    }, decodedResult: {
                        successAction($0)
                    })

                }, error: { response in

                    // Error
                    jsonResponse.decodeErrorResponse(response, to: [TaskList].self) {completion($0)}
                })
            }

            let projectTaskListPath = String(format: taskListsPath, projectId)
            var queries = [URLQueryItem]()

            if let taskListQuery = taskListQuery, taskListQuery.taskListStatusFilterType != .default {
                let filterQueryItem = URLQueryItem(name: "status", value: taskListQuery.taskListStatusFilterType.rawValue)
                queries.append(filterQueryItem)
            }

            getTaskList(projectTaskListPath, partialData.nextPageQueries ?? queries)
        }
        return token
    }
}
