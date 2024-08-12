//
//  LaunchResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation

/// Model to represent the outermost response object for launches.
public struct LaunchResponseModel: Decodable {
    public let docs: [LaunchModel] // Array of launch models representing individual launches
}

/// Model representing a SpaceX launch.
public struct LaunchModel: Decodable {
    
    // MARK: - Properties
    
    public let id: String
    public let name: String
    public let date_utc: String
    public let success: Bool?
    public let rocket: RocketResponseModel? // Optional model representing the rocket used in the launch
    public let links: LinksResponseModel? // Optional model for additional launch data such as media links
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `LaunchModel`.
    /// - Parameters:
    ///   - id: The unique identifier of the launch.
    ///   - name: The name of the launch.
    ///   - date_utc: The date and time of the launch in UTC format.
    ///   - success: A boolean indicating whether the launch was successful.
    ///   - rocket: An optional `RocketResponseModel` object containing details about the rocket.
    ///   - links: An optional `LinksResponseModel` object containing additional data related to the launch.
    public init(
        id: String,
        name: String,
        date_utc: String,
        success: Bool?,
        rocket: RocketResponseModel?,
        links: LinksResponseModel?
    ) {
        self.id = id
        self.name = name
        self.date_utc = date_utc
        self.success = success
        self.rocket = rocket
        self.links = links
    }
}
