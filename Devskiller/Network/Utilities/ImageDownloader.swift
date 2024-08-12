//
//  ImageDownloader.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// ImageDownloader is responsible for downloading and caching images.
class ImageDownloader {
    
    // MARK: - Singleton Instance
    static let shared = ImageDownloader()
    
    // MARK: - Private Initializer
    private init() {}
    
    // MARK: - Properties
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Image Downloading

    /// Downloads an image from the provided URL. If the image is cached, it returns the cached image.
    /// - Parameter url: The URL of the image to download.
    /// - Parameter completion: A closure that is called with the downloaded image, or nil if the download fails.
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Download the image if not cached
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // Handle error or missing data
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            // Cache the downloaded image
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
        }
        task.resume()
    }
}
