//
//  CoreDataConstants.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// CoreDataConstants contains constants used for Core Data operations.
struct CoreDataConstants {
    
    // MARK: - Core Data Model
    
    /// The name of the Core Data model.
    static let modelName = "Devskiller"
    
    // MARK: - Entity Names
    
    /// Constants for Core Data entity names.
    struct Entities {
        static let companyCoreDataModel = "CompanyCoreDataModel"
        static let launchCoreDataModel = "LaunchCoreDataModel"
    }
    
    // MARK: - Error Messages
    
    /// Constants for error messages used in Core Data operations.
    struct Messages {
        static let failedToDeleteCompanyData = "Failed to delete company data."
        static let failedToFetchCompanyData = "Failed to fetch company data."
        static let failedToDeleteLaunchData = "Failed to delete launch data."
        static let failedToFetchLaunchData = "Failed to fetch launch data."
        
        // General Core Data related error messages
        static let dataClearError = "Failed to clear data."
        static let dataSaveError = "Failed to save data."
        static let dataFetchError = "Failed to fetch data."
    }
}
