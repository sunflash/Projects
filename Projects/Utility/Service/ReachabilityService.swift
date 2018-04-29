//
//  ReachabilityService.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import SwiftMessages

struct ReachabilityService: Log {

    static var noConnectionMessage = NSLocalizedString("NoConnectionMessage", comment: "Status")

    static var hosts = ["www.google.com", "www.apple.com"]

    static func setup() {
        let reachabilityStatus = ReachabilityDetection.shared.startReachabilityMonitoring(hosts: hosts)
        log(.INFO, "Internet:  \(reachabilityStatus.success), \(reachabilityStatus.description)")
        let reachabilityCompletionHandler: (Bool) -> Void = { isInternetAvailable in
            if isInternetAvailable == false {
                Message.showErrorMessage(text: noConnectionMessage, forever: true)
            } else {
                SwiftMessages.hideAll()
            }
        }
        ReachabilityDetection.shared.reachabilityStatusCompletionHandlers["Internet"] = reachabilityCompletionHandler
    }
}
