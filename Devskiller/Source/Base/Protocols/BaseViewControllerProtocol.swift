//
//  BaseViewControllerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// A protocol that defines the basic setup requirements for a view controller.
protocol BaseViewControllerProtocol: AnyObject {
    
    /// Sets up the user interface elements of the view controller.
    /// This method should be implemented by conforming classes to define their UI setup logic.
    func setupUI()
    
    /// Sets up the bindings between the view and the view model or other data sources.
    /// This method should be implemented by conforming classes to define their data binding logic.
    func setupBindings()
}
