//
//  EnumStatus.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

enum LaunchStatus: String, Codable, CaseIterable {
    case all = "All"
    case success = "Success"
    case failed = "Failed"
    
    /// A human-readable name for the launch status, useful for displaying in the UI.
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    /// Returns the corresponding API parameter value for the launch status.
    var apiParameter: String? {
        switch self {
        case .all:
            return nil // or "all" if your API supports it
        case .success:
            return "success"
        case .failed:
            return "failed"
        }
    }
}
