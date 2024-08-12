//
//  TableViewHandlerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for handling table view configuration and data updates.
protocol TableViewHandlerProtocol: UITableViewDataSource, UITableViewDelegate {
    
    /// Configures the table view with necessary setup.
    /// - Parameter tableView: The UITableView to be configured.
    func configure(tableView: UITableView)
    
    /// Updates the table view data with the provided launches.
    /// - Parameter launches: An array of `LaunchListModel` objects to update the table view.
    func updateData(_ launches: [LaunchListModel])
}
