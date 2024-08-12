//
//  LaunchDetailModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing the detailed information of a SpaceX launch.
struct LaunchDetailModel {
    let id: String
    let name: String
    let date: String
    let success: Bool?
    let rocketName: String?
    let rocketType: String?
    let missionPatchURL: String?
    let articleURL: URL?
    let wikipediaURL: URL?
    let videoID: String?
    let details: String?

    /// Initializes the `LaunchDetailModel` from a `LaunchDetailResponseModel`.
    /// - Parameter responseModel: The response model containing launch details from the API.
    init(from responseModel: LaunchDetailResponseModel) {
        self.id = responseModel.id
        self.name = responseModel.name
        self.date = responseModel.date_utc
        self.success = responseModel.success
        self.rocketName = "" // This might need to be populated with actual data if available
        self.rocketType = "" // This might need to be populated with actual data if available
        self.articleURL = responseModel.links?.article?.toURL() // Converts the article link string to URL
        self.wikipediaURL = responseModel.links?.wikipedia?.toURL() // Converts the wikipedia link string to URL
        self.missionPatchURL = responseModel.links?.patch?.small // Extracts the small patch image URL
        self.videoID = responseModel.links?.youtube_id
        self.details = responseModel.details
    }
}
