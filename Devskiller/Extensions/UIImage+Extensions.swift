//
//  UIImage+Extensions.swift
//  Devskiller
//
//  Created by Muhammad Umair  on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

// Extension on UIImageView to add the functionality of setting an image from a URL with a placeholder and completion handler.
extension UIImageView {
    
    /// Sets an image from a provided URL. If the URL is `nil` or the image download fails, it sets a placeholder image instead.
    ///
    /// - Parameters:
    ///   - url: The URL to download the image from.
    ///   - placeholder: The name of the placeholder image to use if the URL is `nil` or the image download fails. Default is `LaunchCellConstants.Placeholders.placeholderImage`.
    ///   - completion: A closure that gets called after the image is set.
    func setImage(from url: URL?, placeholder: String = LaunchCellConstants.Placeholders.placeholderImage, completion: (() -> Void)? = nil) {
        // If the URL is nil, set the placeholder image and return
        guard let url = url else {
            self.image = UIImage(named: placeholder)
            completion?() // Call completion handler if provided
            return
        }
        
        // Use a shared image downloader to fetch the image from the URL
        ImageDownloader.shared.downloadImage(from: url) { [weak self] image in
            // Ensure the UI update happens on the main thread
            DispatchQueue.main.async {
                // Set the downloaded image, or the placeholder if download failed
                self?.image = image ?? UIImage(named: placeholder)
                // Call completion handler if provided
                completion?()
            }
        }
    }
}
