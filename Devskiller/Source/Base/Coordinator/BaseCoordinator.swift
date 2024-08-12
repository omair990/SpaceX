//
//  BaseCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit

/// BaseCoordinator handles common navigation tasks and manages child coordinators.
class BaseCoordinator {
    
    // MARK: - Properties
    
    /// The UINavigationController used for navigation.
    var navigationController: UINavigationController
    
    /// List of child coordinators to manage the flow of multiple parts of the application.
    var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Initializer
    
    /// Initializes the coordinator with a UINavigationController.
    /// - Parameter navigationController: The navigation controller used for navigation tasks.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Management
    
    /// Adds a child coordinator to the list of child coordinators.
    /// - Parameter coordinator: The coordinator to be added.
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    /// Removes a child coordinator from the list of child coordinators.
    /// - Parameter coordinator: The coordinator to be removed.
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    // MARK: - Navigation Methods
    
    /// Pushes a view controller onto the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to be pushed onto the stack.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    /// Presents a view controller modally.
    /// - Parameters:
    ///   - viewController: The view controller to be presented.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    ///   - completion: A closure to be executed after the presentation finishes.
    func presentViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    /// Pops the top view controller from the navigation stack.
    /// - Parameter animated: A Boolean value indicating whether the transition is animated.
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
