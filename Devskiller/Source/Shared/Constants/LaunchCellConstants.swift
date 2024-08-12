//
//  LaunchCellConstants.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// LaunchCellConstants contains constants used in the LaunchCell module.
struct LaunchCellConstants {
    
    // MARK: - Font Sizes
    
    /// Font size for the mission name label.
    static let missionNameFontSize: CGFloat = 16
    
    /// Default font size for other labels.
    static let defaultFontSize: CGFloat = 14
    
    // MARK: - Label Texts
    
    /// Constants related to label texts used in the LaunchCell.
    struct Labels {
        static let missionTitle = "Mission:"
        static let dateTitle = "Date/time:"
        static let rocketTitle = "Rocket:"
        static let daysTitle = "Days:"
        static let daysSinceNow = "Days Since Now:"
        static let daysFromNow = "Days From Now:"
    }
    
    // MARK: - Placeholder Texts
    
    /// Constants related to placeholder texts used in the LaunchCell.
    struct Placeholders {
        static let unknownRocketType = "Unknown Type"
        static let placeholderImage = "placeholder"
        static let unknownMissionName = "Unknown Mission Name"
        static let unknownDate = "Unknown Date"
        static let unknownRocket = "Unknown Rocket"
        static let unknownDetails = "Details not available"
    }
    
    // MARK: - Layout Constraints
    
    /// Constants related to layout constraints used in the LaunchCell.
    struct Constraints {
        static let imageLeading: CGFloat = 16
        static let imageSize: CGFloat = 50
        static let textLeading: CGFloat = 16
        static let textTrailing: CGFloat = -16
        static let textVerticalSpacing: CGFloat = 4
        static let textBottomSpacing: CGFloat = -16
    }
}
