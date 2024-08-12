//
//  OtherExtensions.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extensions for Font and Style Application

extension UISegmentedControl {
    /// Applies the default font style to the segmented control.
    ///
    /// This method sets the font for all segments to a custom font defined in `UIConstants`.
    /// If the custom font is not found, it falls back to the system font.
    func applyDefaultFont() {
        let font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.missionFontSize) ?? UIFont.systemFont(ofSize: UIConstants.FontSize.missionFontSize)
        let fontAttribute = [NSAttributedString.Key.font: font]
        setTitleTextAttributes(fontAttribute, for: .normal)
    }
}

extension UIApplication {
    /// Opens a specified URL using the application.
    ///
    /// - Parameter url: The URL to be opened by the app.
    func openAppURL(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
