//
//  CompanyResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing the response data for a company.
public struct CompanyResponseModel: Codable {
    
    // MARK: - Properties
    
    public var name: String
    public var founder: String
    public var founded: Int
    public var employees: Int
    public var launchSites: Int
    public var valuation: Int64
    public var id: String
    
    // MARK: - Coding Keys
    
    /// Coding keys to map the JSON keys to the struct's properties.
    enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case launchSites = "launch_sites" // Maps JSON key "launch_sites" to launchSites property
        case valuation
        case id
    }
}
