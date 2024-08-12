//
//  LaunchDetailCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit

class LaunchDetailCoordinator: LaunchDetailCoordinatorProtocol {
    private let navigationController: UINavigationController

    // Initializer to set up the coordinator with a navigation controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Opens a URL in the default web browser, specifically for Wikipedia links
    func openWikipedia(with url: URL) {
        UIApplication.shared.openAppURL(url)
    }

    // Opens a URL in the default web browser, specifically for YouTube links
    func openYouTube(with url: URL) {
        UIApplication.shared.openAppURL(url)
    }

    // Opens a URL in the default web browser, specifically for general websites
    func openWebsite(with url: URL) {
        UIApplication.shared.openAppURL(url)
    }

    // Dismisses the current view controller by popping it from the navigation stack
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
