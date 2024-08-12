//
//  LaunchListCoordinatorProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for handling navigation from the LaunchListViewController.
protocol LaunchListCoordinatorProtocol: AnyObject {
    
    /// Starts the coordinator and sets up the initial view controller.
    func start()
    
    /// Navigates to the detail view for a selected launch.
    /// - Parameter launch: The selected launch model to display details for.
    func showLaunchDetail(for launch: LaunchListModel)
}
