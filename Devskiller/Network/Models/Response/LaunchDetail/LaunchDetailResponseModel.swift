//
//  LaunchDetailResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing a SpaceX launch.
public struct LaunchDetailResponseModel: Decodable {
    
    // MARK: - Properties
    
    public let id: String
    public let name: String
    public let date_utc: String
    public let success: Bool?
    public let rocket: String?
    public let links: LinksResponseModel? // The links model for additional launch data
    public let details: String? // Field for launch description
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `LaunchDetailResponseModel`.
    /// - Parameters:
    ///   - id: The unique identifier of the launch.
    ///   - name: The name of the launch.
    ///   - date_utc: The date and time of the launch in UTC format.
    ///   - success: A boolean indicating whether the launch was successful.
    ///   - rocket: The identifier of the rocket used for the launch.
    ///   - links: An optional `LinksResponseModel` containing additional data related to the launch.
    ///   - details: An optional string containing additional details or description of the launch.
    public init(
        id: String,
        name: String,
        date_utc: String,
        success: Bool?,
        rocket: String?,
        links: LinksResponseModel?,
        details: String?
    ) {
        self.id = id
        self.name = name
        self.date_utc = date_utc
        self.success = success
        self.rocket = rocket
        self.links = links
        self.details = details
    }
}
