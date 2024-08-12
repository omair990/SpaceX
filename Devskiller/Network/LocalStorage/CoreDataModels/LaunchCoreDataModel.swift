//
//  LaunchCoreDataModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import CoreData

/// Core Data entity for storing launch data.
@objc(LaunchCoreDataModel)
public class LaunchCoreDataModel: NSManagedObject {

    // MARK: - Core Data Properties
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var date_utc: String?
    @NSManaged public var success: Bool
    @NSManaged public var rocket_name: String?
    @NSManaged public var rocket_type: String?
    @NSManaged public var rocket_id: String?
    
    // Links to mission patches
    @NSManaged public var missionPatchSmall: String?
    @NSManaged public var missionPatchLarge: String?
    
    // Additional links
    @NSManaged public var youtubeID: String?
    @NSManaged public var article: String?
    @NSManaged public var wikipedia: String?

    // MARK: - Fetch Request
    
    /// Fetch request for retrieving LaunchCoreDataModel objects.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchCoreDataModel> {
        return NSFetchRequest<LaunchCoreDataModel>(entityName: CoreDataConstants.Entities.launchCoreDataModel)
    }
    
    // MARK: - Convenience Methods
    
    /// Updates the Core Data entity with data from a `LaunchModel` object.
    /// - Parameter model: The `LaunchModel` object containing the new data.
    public func updateLaunchInfo(with model: LaunchModel) {
        self.id = model.id
        self.name = model.name
        self.date_utc = model.date_utc
        self.success = model.success ?? false
        self.rocket_name = model.rocket?.name
        self.rocket_type = model.rocket?.type
        self.rocket_id = model.rocket?.id
        self.youtubeID = model.links?.youtube_id
        self.article = model.links?.article
        self.wikipedia = model.links?.wikipedia
        self.missionPatchSmall = model.links?.patch?.small
        self.missionPatchLarge = model.links?.patch?.large
    }
    
    /// Converts the Core Data entity to a `LaunchModel` object.
    /// - Returns: A `LaunchModel` object representing the current Core Data entity.
    public func toLaunchModel() -> LaunchModel {
        let links = LinksResponseModel(
            patch: LinksResponseModel.PatchResponseModel(
                small: self.missionPatchSmall,
                large: self.missionPatchLarge
            ),
            youtube_id: self.youtubeID,
            article: self.article,
            wikipedia: self.wikipedia
        )

        let rocket = RocketResponseModel(
            name: self.rocket_name,
            type: self.rocket_type,
            id: self.rocket_id
        )

        return LaunchModel(
            id: self.id ?? "",
            name: self.name ?? "",
            date_utc: self.date_utc ?? "",
            success: self.success,
            rocket: rocket,
            links: links
        )
    }
}
