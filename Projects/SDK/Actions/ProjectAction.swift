//
//  ProjectAction.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

struct AllProjects: Mappable {
    var projects: [Project]?
    init() {}
    var propertyValues: [String: Any] {return propertyValuesRaw}
}

public struct ProjectQuery {

    public var projectStatusFilterType: ProjectStatusFilterType = .default
}

struct ProjectAction: Log {

    private static let allProjectsPath = "projects.json"

    private static let jsonResponse: JSONResponse = {
        let response = JSONResponse()
        response.useISO8601 = true
        return response
    }()

    static func getAllProjects(_ projectQuery: ProjectQuery?,
                               partialData: PartilaData<Project> = PartilaData(),
                               completion: @escaping (HTTPResults<[Project]>) -> Void) -> RequestCancellationToken? {

        var token: RequestCancellationToken? = partialData.cancellationToken

        GCD.userInitiated.queue.async {

            let getProjects: (String, [URLQueryItem]) -> Void = { path, queries in

                // Combine projects with pagination
                let transformation: ([Project]?) -> [Project]? = {
                    if let currentPageProjects = $0 {
                        return partialData.partialResults + currentPageProjects
                    } else {
                        return $0
                    }
                }

                // Success action
                let successAction: (HTTPResults<[Project]>) -> Void = {
                    if let nextPageQueries = APIService.isNextPage(path: path, queries: queries, headers: $0.headers), let projects = $0.object {

                        _ = getAllProjects(projectQuery,
                                           partialData: PartilaData<Project>(nextPageQueries: nextPageQueries, partialResults: projects, cancellationToken: token),
                                           completion: completion)
                    } else {
                        completion($0)
                    }
                }

                // Get projects request
                let requestPath = ((queries.isEmpty == false) ? HTTPRequest.pathWithQuery(path: path, queryItems: queries) : path) ?? path
                var request = HTTPRequest(path: requestPath)
                request.expectedResponseContentType = .JSON

                token = ProjectsConfig.client.request(request: request, success: { response in

                    // Success
                    jsonResponse.decodeSuccessResponse(response, from: AllProjects.self, to: [Project].self, transform: {
                        return transformation($0.projects)
                    }, decodedResult: {
                        successAction($0)
                    })

                }, error: { response in

                    // Error
                    jsonResponse.decodeErrorResponse(response, to: [Project].self) {completion($0)}
                })
            }

            var queries = [URLQueryItem]()
            if let projectQuery = projectQuery, projectQuery.projectStatusFilterType != .default {
                let filterQueryItem = URLQueryItem(name: "status", value: projectQuery.projectStatusFilterType.rawValue)
                queries.append(filterQueryItem)
            }
            getProjects(allProjectsPath, partialData.nextPageQueries ?? queries)
        }
        return token
    }
}
