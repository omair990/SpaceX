//
//  FilterViewControllerDelegate.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// Protocol to handle the application of filters in the filter view controller.
protocol FilterViewControllerDelegate: AnyObject {
    /// Applies the filter based on the provided parameters.
    /// - Parameters:
    ///   - year: The year to filter launches by, if any.
    ///   - status: The status to filter launches by (e.g., success, failed, all).
    ///   - isAscending: Boolean indicating whether the launches should be sorted in ascending order.
    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool)
}
