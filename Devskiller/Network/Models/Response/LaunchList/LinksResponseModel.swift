//
//  LinksResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing the links related to a SpaceX launch.
public struct LinksResponseModel: Codable {
    
    // MARK: - Properties
    
    public let patch: PatchResponseModel? // Optional patch images (small and large)
    public let youtube_id: String? // Optional YouTube video ID
    public let article: String? // Optional URL to an article about the launch
    public let wikipedia: String? // Optional URL to the Wikipedia page for the launch
    
    // MARK: - Nested Model
    
    /// Model representing patch images (small and large).
    public struct PatchResponseModel: Codable {
        public let small: String? // Optional URL for a small patch image
        public let large: String? // Optional URL for a large patch image
    }
}
