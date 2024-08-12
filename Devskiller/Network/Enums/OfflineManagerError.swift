//
//  OfflineManagerError.swift
//  Devskiller
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Enum representing different types of errors that can occur in the OfflineManager.
enum OfflineManagerError: Error {
    case dataClearError(String)  // Error when clearing data fails
    case dataFetchError(String)  // Error when fetching data fails
    case dataSaveError(String)   // Error when saving data fails
    
    /// Returns a localized description of the error, which can be used for displaying user-friendly messages.
    var localizedDescription: String {
        switch self {
        case .dataClearError(let message):
            return message
        case .dataFetchError(let message):
            return message
        case .dataSaveError(let message):
            return message
        }
    }
}

