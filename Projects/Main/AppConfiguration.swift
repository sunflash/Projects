//
//  AppConfiguration.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation

public struct AppConfiguration: Log {

    // MARK: - Config Loading

    static func loadAppConfig() {
        configurLogging()
        printBuildEnvironmentInfo()
    }

    // MARK: - Build Environment, Logging Configuration

    enum BuildConfiguration {
        case debug
        case release
        case unknown
    }

    static let buildConfiguration: BuildConfiguration = {
        #if DEBUG
        return BuildConfiguration.debug
        #elseif RELEASE
        return BuildConfiguration.release
        #else
        return BuildConfiguration.unknown
        #endif
    }()

    private static func configurLogging() {
        if buildConfiguration == .debug {
            LogGlobalConfig.showInfoLog = true
            LogGlobalConfig.showWarningLog = true
            LogGlobalConfig.showDebugLog = true
            LogGlobalConfig.showErrorLog = true
            LogGlobalConfig.showAPILog = true
            LogGlobalConfig.showCoderLog = true
            LogGlobalConfig.showDBLog = true
        }
    }

    private static func printBuildEnvironmentInfo() {
        switch buildConfiguration {
        case .debug:
            log(.INFO, "DEBUG Mode")
            log(.INFO, FileService.directoryPath(directory: .documentDirectory) ?? "")
        case .release:
            print("INFO: RELEASE Mode.")
        case .unknown:
            print("INFO: UNKNOWN Mode.")
        }
    }
}
