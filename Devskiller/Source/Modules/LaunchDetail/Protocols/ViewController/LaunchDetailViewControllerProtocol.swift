//
//  LaunchDetailViewControllerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Protocol defining the interface for the LaunchDetailViewController.
protocol LaunchDetailViewControllerProtocol: AnyObject {
    /// The view model associated with the view controller.
    var viewModel: LaunchDetailViewModelProtocol { get }
    
    /// Method to display an error message.
    /// - Parameter message: The error message to be displayed.
    func showError(_ message: String)
}
