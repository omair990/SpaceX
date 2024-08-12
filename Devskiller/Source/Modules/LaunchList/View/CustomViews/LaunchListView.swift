//
//  LaunchListView.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit


// LaunchListView is responsible for displaying the list of launches in a table view.
class LaunchListView: UIView {
    
    // Public table view to display the list of launches.
    let tableView = UITableView()
    
    // Initializer that sets up the view and its subviews.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets up the table view by configuring its properties and adding it to the view.
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UIConstants.LaunchList.launchCellIdentifier)
        addSubview(tableView)
        
        // Add constraints to make the table view fill the entire view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
