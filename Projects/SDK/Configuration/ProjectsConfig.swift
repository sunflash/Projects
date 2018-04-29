//
//  Config.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

/// Global configuration
public class ProjectsConfig: Log {

    // MARK: - User configuration

    /// Host URL
    public static var host: URL? {
        didSet {
            client.sessionBaseURL = host
            updateHeader()
        }
    }

    /// User name
    public static var userName: String? {
        didSet {updateHeader()}
    }

    /// Password
    public static var password: String? {
        didSet {updateHeader()}
    }

    // MARK: - Config setup

    /// Shared http client
    static let client: HTTPClient = {
        let client = HTTPClient()
        client.retry = 3
        return client
    }()

    /// Update header
    private static func updateHeader() {

        var header = [String: String]()

        guard let name = userName, name.isEmpty == false else {
            updateClientConfiguration(header)
            return
        }
        guard let pass = password, pass.isEmpty == false else {
            updateClientConfiguration(header)
            return
        }
        guard let authorizationHeader = HTTPRequest.basicAuthenticationHeader(userName: name, password: pass) else {
            log(.ERROR, "Username or password contain only whitespace.")
            updateClientConfiguration(header)
            return
        }

        header += authorizationHeader
        updateClientConfiguration(header)
    }

    /// Update client configuration for authenticaion and other addiction info
    static func updateClientConfiguration(_ header: [String: String] = [String: String]()) {

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = header
        client.configuration = configuration
    }
}
