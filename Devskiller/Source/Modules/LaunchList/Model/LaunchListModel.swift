//
//  LaunchListModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// A model representing a launch with properties formatted for UI usage.
struct LaunchListModel {
    let id: String
    let name: String
    let date: String
    let success: Bool?
    let rocket_name: String?
    let rocket_type: String?
    let missionPatchURL: String?
    let articleURL: URL?
    let wikipediaURL: URL?
    let videoID: String?

    // Initializes a LaunchListModel from a LaunchModel
    init(from responseModel: LaunchModel) {
        self.id = responseModel.id
        self.name = responseModel.name
        self.date = responseModel.date_utc
        self.success = responseModel.success
        self.rocket_name = responseModel.rocket?.name
        self.rocket_type = responseModel.rocket?.type
        self.articleURL = responseModel.links?.article?.toURL()
        self.wikipediaURL = responseModel.links?.wikipedia?.toURL()
        self.missionPatchURL = responseModel.links?.patch?.small
        self.videoID = responseModel.links?.youtube_id
    }
}

// Extension to convert LaunchListModel back to LaunchModel
extension LaunchListModel {
    func toLaunchModel() -> LaunchModel {
        return LaunchModel(
            id: self.id,
            name: self.name,
            date_utc: self.date,
            success: self.success,
            rocket: RocketResponseModel(
                name: self.rocket_name,
                type: self.rocket_type,
                id: nil
            ),
            links: LinksResponseModel(
                patch: LinksResponseModel.PatchResponseModel(
                    small: self.missionPatchURL,
                    large: nil
                ),
                youtube_id: self.videoID,
                article: self.articleURL?.absoluteString,
                wikipedia: self.wikipediaURL?.absoluteString
            )
        )
    }
}
