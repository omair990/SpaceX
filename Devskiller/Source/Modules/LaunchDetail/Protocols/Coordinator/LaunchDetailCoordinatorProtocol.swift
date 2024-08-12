//
//  LaunchDetailCoordinatorProtocol.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation

/// Protocol defining the coordination actions for the Launch Detail feature.
protocol LaunchDetailCoordinatorProtocol: AnyObject {
    /// Opens a Wikipedia page with the given URL.
    /// - Parameter url: The URL of the Wikipedia page.
    func openWikipedia(with url: URL)
    
    /// Opens a YouTube video with the given URL.
    /// - Parameter url: The URL of the YouTube video.
    func openYouTube(with url: URL)
    
    /// Opens a website with the given URL.
    /// - Parameter url: The URL of the website.
    func openWebsite(with url: URL)
    
    /// Dismisses the current view or pop the current view controller.
    func dismiss()
}
