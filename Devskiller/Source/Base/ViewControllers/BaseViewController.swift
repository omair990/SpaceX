//
//  BaseViewController.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// A base view controller that provides common setup methods for UI and bindings.
/// Subclasses can override `setupUI` and `setupBindings` to customize their behavior.
class BaseViewController: UIViewController, BaseViewControllerProtocol {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("View did load")

        setupUI()
        setupBindings()
    }

    // MARK: - Setup Methods
    
    /// Sets up the user interface. Subclasses should override this method to provide custom UI setup.
    func setupUI() {
        // Default implementation (can be overridden)
    }
    
    /// Sets up the bindings between the view and the view model. Subclasses should override this method to provide custom bindings.
    func setupBindings() {
        // Default implementation (can be overridden)
    }
}
