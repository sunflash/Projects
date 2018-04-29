//
//  AppDelegate+Setup.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {

    func configureApp(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {

        self.appRouter = AppRouter()
        UIConfiguration.loadUIConfig()
        AppConfiguration.loadAppConfig()
        ServerConfiguration.loadServerEndpointConfig()
        ReachabilityService.setup()
    }
}
