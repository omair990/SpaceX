//
//  UIConstants.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// UIConstants contains constants used for UI elements throughout the app.
struct UIConstants {
    
    // MARK: - Launch List Constants
    
    /// Constants related to the launch list UI elements.
    struct LaunchList {
        static let launchCellIdentifier = "LaunchCellIdentifier" // Identifier for launch cells
        static let launchTableIdentifier = "LaunchTableView" // Identifier for the launch table view
    }
    
    // MARK: - Corner Radius
    
    /// Constants for corner radius values used in UI elements.
    struct CornerRadius {
        static let small = 15.0 // Small corner radius value
    }
    
    // MARK: - Error Messages
    
    /// Constants related to error messages displayed in the UI.
    struct Error {
        static let title = "Error" // Title for error alerts
        static let okButtonTitle = "OK" // Title for OK button in alerts
    }

    // MARK: - Fonts
    
    /// Constants related to fonts used in the app.
    struct Fonts {
        static let regularFont = "Inter-Regular" // Regular font name
        static let boldFont = "Inter-Bold" // Bold font name
        static let mediumFont = "Inter-Medium" // Medium font name
    }
    
    // MARK: - Colors
    
    /// Constants for colors used throughout the app.
    struct Colors {
        static let buttonBackground = UIColor.black // Background color for buttons
        // Add other colors as needed
    }
    
    // MARK: - Spacing
    
    /// Constants for spacing and padding values used in the layout.
    struct Spacing {
        static let small: CGFloat = 8 // Small spacing value
        static let medium: CGFloat = 16 // Medium spacing value
        static let large: CGFloat = 24 // Large spacing value
    }
    
    // MARK: - Font Sizes
    
    /// Constants for font sizes used in different UI elements.
    struct FontSize {
        static let imageSize: CGFloat = 50
        static let imageCornerRadius: CGFloat = 8
        static let titleFontSize: CGFloat = 14
        static let missionFontSize: CGFloat = 16
        static let detailFontSize: CGFloat = 14
        static let headerFontSize: CGFloat = 18
        static let bodyFontSize: CGFloat = 14
    }
    
    // MARK: - Margins
    
    /// Constants for margin and padding values used in the layout.
    struct Margins {
        static let topMargin: CGFloat = 16 // Top margin value
        static let sideMargin: CGFloat = 16 // Side margin value
        static let bottomMargin: CGFloat = 16 // Bottom margin value
        static let verticalSpacing: CGFloat = 8 // Vertical spacing value
        static let large: CGFloat = 24 // Large margin or spacing
    }
    
    // MARK: - Images
    
    /// Constants related to images used in the app.
    struct Images {
        static let filterIcon = UIImage(named: "filterIcon") // Image for the filter icon
    }
}
