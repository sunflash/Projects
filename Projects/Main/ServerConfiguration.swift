//
//  ServerConfiguration.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public struct ServerConfiguration {

    enum ServerEnvironmentType: String {
        case DEV
        case SIT
        case UAT
        case PRODUCTION
    }

    // Note: Change `currentServerEnvironment` to choose server environment that app would use

    static var currentServerEnvironment: ServerEnvironmentType = .PRODUCTION

    // MARK: - Server Endpoint Configuration

    static func loadServerEndpointConfig() {
        printCurrentServerEnvironmentInfo()
        setupAPIEndpoint()
    }

    private static func printCurrentServerEnvironmentInfo() {
        print("INFO: Running app with \(currentServerEnvironment) configuration.")
    }

    private static func setupAPIEndpoint() {

        switch currentServerEnvironment {
        case .DEV, .SIT, .UAT:
            break
        case .PRODUCTION:
            ProjectsConfig.host = URL(string: "https://yat.teamwork.com")
            ProjectsConfig.userName = "yat@triplespin.com"
            ProjectsConfig.password = "yatyatyat27"
        }
    }
}
