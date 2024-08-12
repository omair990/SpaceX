//
//  NetworkError.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Enum representing different types of network errors that can occur.
enum NetworkError: Error, CustomStringConvertible {
    case requestFailed(String)             // Error when a network request fails
    case invalidData(String)               // Error when data received is invalid
    case decodingFailed(String)            // Error when data decoding fails
    case networkError(String)              // Error for generic network issues
    case unknown                           // Error for unknown issues
    case databaseOperationFailed(String)   // Error when a database operation fails
    
    /// Returns a description of the error, which can be used for logging or displaying messages.
    var description: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .invalidData(let message):
            return message
        case .decodingFailed(let message):
            return message
        case .networkError(let message):
            return message
        case .unknown:
            return AppConstants.ErrorMessages.unknownError
        case .databaseOperationFailed(let message):
            return message
        }
    }
}
