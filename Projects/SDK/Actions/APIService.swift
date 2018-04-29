//
//  APIService.swift
//  Projects
//
//  Created by Min Wu on 09/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

struct APIService: Log {

    static var currentPageHeader = "x-page"

    static var totalPagesHeader = "x-pages"

    static func isNextPage(path: String,
                           queries: [URLQueryItem] = [URLQueryItem](),
                           headers: [String: String]) -> [URLQueryItem]? {

        guard path.isEmpty == false else {
            log(.ERROR, "In pagination next page detection, path is empty.")
            return nil
        }

        guard let currentPages = headers[currentPageHeader], let totalPages = headers[totalPagesHeader] else {
            log(.INFO, "\(path): No pagination info in response header.")
            return nil
        }

        let currentPageMax = (currentPages.contains(",")) ? currentPages.split(by: ",").compactMap {UInt($0)}.max() :  UInt(currentPages)

        guard let page = currentPageMax, let pages = UInt(totalPages) else {
            print(headers)
            log(.ERROR, "\(path): Pagination info is NOT number.")
            return nil
        }

        guard page < pages else {
            log(.INFO, "\(path): Last page is \(pages)")
            return nil
        }

        var updatedQueries = queries.filter {$0.name != "page"}
        updatedQueries.append(URLQueryItem(name: "page", value: "\(page+1)"))
        let nextPagePath = HTTPRequest.pathWithQuery(path: path, queryItems: updatedQueries) ?? path
        log(.INFO, "Page \(page+1): \(nextPagePath)")
        return updatedQueries
    }
}

struct PartilaData<R> {

    var nextPageQueries: [URLQueryItem]?

    var partialResults: [R] = [R]()

    var cancellationToken: RequestCancellationToken?
}
