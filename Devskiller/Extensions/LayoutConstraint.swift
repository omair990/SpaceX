//
//  LayoutConstraint.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    /// Sets the priority of the NSLayoutConstraint and returns the constraint itself.
    ///
    /// - Parameter priority: The UILayoutPriority to be set for the constraint.
    /// - Returns: The NSLayoutConstraint with the updated priority.
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
