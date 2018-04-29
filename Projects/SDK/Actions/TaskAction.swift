//
//  TaskAction.swift
//  Projects
//
//  Created by Min Wu on 15/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

//-------------------------------------------------------------------------------------------------------------
// MARK: - Response Object

struct TaskItems: Mappable {

    var taskItems: [TaskItem]?

    enum CodingKeys: String, CodingKey {
        case taskItems = "todo-items"
    }

    init() {}
    var propertyValues: [String: Any] {return propertyValuesRaw}
}

struct Status: Mappable {

    var status: String?

    enum CodingKeys: String, CodingKey {
        case status = "STATUS"
    }

    init() {}
    var propertyValues: [String: Any] {return propertyValuesRaw}
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task Query

public struct TaskQuery {

    // todo: support query options later
    // https://developer.teamwork.com/todolistitems#retrieve_all_task
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task Action

struct TaskAction: Log {

    private static let taskListsTasksPath = "tasklists/%@/tasks.json"
    private static let taskCompletePath = "tasks/%d/complete.json"
    private static let taskUncompletePath = "tasks/%d/uncomplete.json"

    private static let jsonResponse: JSONResponse = {
        let response = JSONResponse()
        response.useISO8601 = true
        return response
    }()

    /// Get Task List Task
    static func getTasks(taskListId: String,
                         taskQuery: TaskQuery?,
                         partialData: PartilaData<TaskItem> = PartilaData(),
                         completion: @escaping (HTTPResults<[TaskItem]>) -> Void) -> RequestCancellationToken? {

        var token: RequestCancellationToken? = partialData.cancellationToken

        GCD.userInitiated.queue.async {

            let getTask: (String, [URLQueryItem]) -> Void = { path, queries in

                // Combine task with pagination
                let transformation: ([TaskItem]?) -> [TaskItem]? = {
                    if let currentTasks = $0 {
                        return partialData.partialResults + currentTasks
                    } else {
                        return $0
                    }
                }

                // Success action
                let successAction: (HTTPResults<[TaskItem]>) -> Void = {
                    if let nextPageQueries = APIService.isNextPage(path: path, queries: queries, headers: $0.headers), let tasks = $0.object {

                        let data = PartilaData(nextPageQueries: nextPageQueries, partialResults: tasks, cancellationToken: token)

                        _ = getTasks(taskListId: taskListId,
                                     taskQuery: taskQuery,
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
                    jsonResponse.decodeSuccessResponse(response, from: TaskItems.self, to: [TaskItem].self, transform: {
                        return transformation($0.taskItems)
                    }, decodedResult: {
                        successAction($0)
                    })

                }, error: { response in

                    // Error
                    jsonResponse.decodeErrorResponse(response, to: [TaskItem].self) {completion($0)}
                })
            }

            let taskListTasksPath = String(format: taskListsTasksPath, taskListId)

            let queries = [URLQueryItem]()
//            if let taskQuery = taskQuery {
//                  todo: support query options later
//            }

            getTask(taskListTasksPath, partialData.nextPageQueries ?? queries)
        }
        return token
    }

    /// Complete Task
    static func completeTask(taskId: Int64, completion: @escaping (HTTPResults<String>) -> Void) -> RequestCancellationToken? {

        var token: RequestCancellationToken?

        GCD.userInitiated.queue.async {

            let completeTaskPath = String(format: taskCompletePath, taskId)

            var request = HTTPRequest(path: completeTaskPath, method: .put)
            request.expectedResponseContentType = .JSON

            token = ProjectsConfig.client.request(request: request, success: { response in

                jsonResponse.decodeSuccessResponse(response, from: Status.self, to: String.self, transform: {
                    return $0.status
                }, decodedResult: {
                    completion($0)
                })

            }, error: { response in

                jsonResponse.decodeErrorResponse(response, to: String.self) {completion($0)}
            })
        }
        return token
    }

    /// Uncomplete Task
    static func uncompleteTask(taskId: Int64, completion: @escaping (HTTPResults<String>) -> Void) -> RequestCancellationToken? {

        var token: RequestCancellationToken?

        GCD.userInitiated.queue.async {

            let uncompleteTaskPath = String(format: taskUncompletePath, taskId)

            var request = HTTPRequest(path: uncompleteTaskPath, method: .put)
            request.expectedResponseContentType = .JSON

            token = ProjectsConfig.client.request(request: request, success: { response in

                jsonResponse.decodeSuccessResponse(response, from: Status.self, to: String.self, transform: {
                    return $0.status
                }, decodedResult: {
                    completion($0)
                })

            }, error: { response in

                jsonResponse.decodeErrorResponse(response, to: String.self) {completion($0)}
            })
        }
        return token
    }
}
