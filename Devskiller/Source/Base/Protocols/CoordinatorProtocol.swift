//
//  CoordinatorProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// CoordinatorProtocol defines the basic requirements for a coordinator.
protocol CoordinatorProtocol: AnyObject {
    
    /// List of child coordinators managed by this coordinator.
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    /// The UINavigationController used for navigation tasks.
    var navigationController: UINavigationController { get set }
    
    /// Starts the coordinator, typically by setting up the initial view controller and navigation flow.
    func start()
    
    /// Adds a child coordinator to the list of child coordinators.
    /// - Parameter coordinator: The coordinator to be added.
    func addChildCoordinator(_ coordinator: CoordinatorProtocol)
    
    /// Removes a child coordinator from the list of child coordinators.
    /// - Parameter coordinator: The coordinator to be removed.
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol)
    
    /// Pushes a view controller onto the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to be pushed onto the stack.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    
    /// Presents a view controller modally.
    /// - Parameters:
    ///   - viewController: The view controller to be presented.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    ///   - completion: A closure to be executed after the presentation finishes.
    func presentViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Pops the top view controller from the navigation stack.
    /// - Parameter animated: A Boolean value indicating whether the transition is animated.
    func popViewController(animated: Bool)
}
