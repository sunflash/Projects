//
//  AppRouter.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import ReSwift
import UIKit

final class AppRouter {

    init() {
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }

    var rootViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}

extension AppRouter: StoreSubscriber {

    func newState(state: RoutingState) {
        switch state.transitionStyle {
        case .replaceRoot:
            self.replaceRootViewController(state: state)
        case .push, .forcePush:
            self.pushViewController(state: state)
        case .modal:
            self.presentViewController(state: state)
        case .none:
            break
        }
    }
}

extension AppRouter {

    private func replaceRootViewController(state: RoutingState) {
        let storyBoard = state.storyBoard
        let destination = state.screen
        let viewControllerType = state.viewControllerType

        guard let newRootViewController = viewController(storyBoard: storyBoard, destination: destination, viewControllerType: viewControllerType) else {return}
        UIApplication.shared.keyWindow?.rootViewController = newRootViewController
    }

    private func viewController(storyBoard: AppStoryBoard, destination: RoutingDestination, viewControllerType: UIViewController.Type) -> UIViewController? {

        if storyBoard == .none {
            return viewControllerType.init(nibName: "\(viewControllerType)", bundle: Bundle.main)
        } else {
            return storyBoard.storyBoard().instantiateViewController(withIdentifier: destination.rawValue)
        }
    }

    private func pushViewController(state: RoutingState) {

        let storyBoard = state.storyBoard
        let destination = state.screen
        let viewControllerType = state.viewControllerType
        guard let viewController = viewController(storyBoard: storyBoard, destination: destination, viewControllerType: viewControllerType) else {return}
        guard let navigationController = rootViewController as? UINavigationController else {return}

        // Prevent push view controller if destination view controller is the same type as current view controller
        let newViewControllerType = type(of: viewController)
        if state.transitionStyle != .forcePush, let currentVC = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVC)
            if currentViewControllerType == newViewControllerType {
                return
            }
        }
        if let configurationVC = state.configuration {
            configurationVC(viewController)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentViewController(state: RoutingState) {

        guard let presentingViewController = (rootViewController as? UINavigationController)?.topViewController ?? rootViewController else {return}

        let storyBoard = state.storyBoard
        let destination = state.screen
        let viewControllerType = state.viewControllerType
        guard let viewController = viewController(storyBoard: storyBoard, destination: destination, viewControllerType: viewControllerType) else {return}

        // Prevent present view controller if destination view controller is the same type as current view controller
        let newViewControllerType = type(of: viewController)
        let presentingViewControllerType = type(of: presentingViewController)
        if presentingViewControllerType == newViewControllerType {
            return
        }
        if let configurationVC = state.configuration {
            configurationVC(viewController)
        }
        presentingViewController.present(viewController, animated: true) {
            guard let completion = state.completion else {return}
            completion(viewController)
        }
    }
}
