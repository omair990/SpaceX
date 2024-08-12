//
//  LaunchListViewControllerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for handling the display and error management in the Launch List view controller.
protocol LaunchListViewControllerProtocol: BaseViewControllerProtocol {
    
    /// Displays a list of launches in the view.
    /// - Parameter launches: An array of `LaunchListModel` objects to be displayed.
    func displayLaunches(_ launches: [LaunchListModel])
    
    /// Shows an error message to the user.
    /// - Parameter message: The error message to be displayed.
    func showError(_ message: String)
}
