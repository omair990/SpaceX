//
//  ErrorHandler.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// ErrorHandler provides a centralized place to handle errors and return user-friendly messages.
class ErrorHandler {
    
    /// Handles a given NetworkError and returns a localized, user-friendly error message.
    /// - Parameter error: The NetworkError to handle.
    /// - Returns: A localized string that represents the error message.
    static func handleError(_ error: NetworkError) -> String {
        switch error {
        case .requestFailed(let message):
            return AppConstants.ErrorMessages.requestFailed.localized(defaultValue: message)
        case .invalidData:
            return AppConstants.ErrorMessages.invalidData.localized()
        case .decodingFailed:
            return AppConstants.ErrorMessages.decodingFailed.localized()
        case .unknown:
            return AppConstants.ErrorMessages.unknownError.localized()
        case .databaseOperationFailed(let message):
            return AppConstants.ErrorMessages.databaseOperationFailed.localized(defaultValue: message)
        case .networkError:
            return AppConstants.ErrorMessages.networkError.localized()
        }
    }
    
    /// Shows an error message as an alert on the specified view controller.
    /// - Parameters:
    ///   - message: The error message to display.
    ///   - viewController: The view controller on which the alert should be presented.
    static func showError(_ message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: UIConstants.Error.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UIConstants.Error.okButtonTitle, style: .default))
        viewController.present(alert, animated: true)
    }
}
