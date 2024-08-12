//
//  MockNavigationController.swift
//  DevskillerTests
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit

/// A mock subclass of UINavigationController used for testing purposes.
/// It captures the view controller that gets pushed onto the navigation stack.
class MockNavigationController: UINavigationController {
    
    /// A property to hold the reference to the view controller that was last pushed.
    var pushedViewController: UIViewController?

    /// Overrides the pushViewController method to capture the view controller being pushed.
    /// - Parameters:
    ///   - viewController: The view controller to be pushed onto the navigation stack.
    ///   - animated: A Boolean value indicating whether the transition is to be animated.
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // Capture the view controller being pushed for testing purposes.
        pushedViewController = viewController
        // Call the superclass implementation to ensure normal behavior.
        super.pushViewController(viewController, animated: animated)
    }
}
