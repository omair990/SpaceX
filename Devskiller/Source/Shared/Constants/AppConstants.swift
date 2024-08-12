//
//  AppConstants.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation


/// AppConstants is a container for all general constant values used throughout the app.
struct AppConstants {
    
    // MARK: - Date Formats
    
    /// Constants related to date formats used across the app.
    struct DateFormats {
        static let displayDateFormat = "dd MMM yyyy" // Format for displaying dates
        static let dateFormat = "yyyy-MM-dd" // Format for saving dates
        static let displayTimeFormat = "HH:mm:ss" // Format for displaying time
    }
    
    // MARK: - Error Messages
    
    /// Constants for general error messages used for user-facing alerts or logs.
    struct ErrorMessages {
        static let unknownError = "An unknown error occurred"
        static let invalidURL = "Invalid URL"
        static let networkError = "Network error occurred"
        static let noData = "No data received"
        static let decodingError = "Failed to decode data"
        static let fetchLaunchesFailed = "Failed to fetch launches"
        static let saveError = "Failed to save context"
        static let clearDataFailed = "Failed to clear existing data"
        static let fetchDataFailed = "Failed to fetch data"
        static let requestFailed = "Request failed"
        static let invalidData = "Invalid data received"
        static let decodingFailed = "Failed to decode data"
        static let loadError = "Failed to load persistent stores"
        static let fetchCompanyInfoFailed = "Failed to fetch company information"
        static let companyInfoDescription = "Details about the company's history, mission, and achievements."
        static let fetchDataError = "Failed to fetch data."
        static let okTitle = "OK"
        static let databaseOperationFailed = "Database operation failed"
        static let unknownMissionName = "Unknown Mission Name"
        static let unknownDate = "Unknown Date"
        static let unknownRocket = "Unknown Rocket"
    }
    
    // MARK: - Navigation
    
    /// Constants related to navigation elements, like titles and accessibility labels.
    struct Navigation {
        static let title = "SpaceX" // Main navigation title
        static let filterIconAccessibilityLabel = "Filter" // Accessibility label for the filter icon
    }
    
    // MARK: - Filter Detail
    
    /// Constants used in the filter detail screen and related actions.
    struct FilterDetail {
        static let okButtonTitle = "OK"
        static let cancelButtonTitle = "Cancel"
        static let launchDetailsTitle = "Launch Details"
        static let openArticleTitle = "Open Article"
        static let openWikipediaTitle = "Open Wikipedia"
        static let openVideoTitle = "Open Video"
        static let chooseOptionTitle = "Choose an option"
        static let cancelTitle = "Cancel"
        static let actionSheetTitle = "Choose an option"
    }
    
    // MARK: - Company Info
    
    /// Constants used for displaying company information.
    struct CompanyInfo {
        static let foundedBy = "%@ was founded by %@ in %d." // Format for company founding details
        static let details = "It has now %d employees, %d launch sites, and is valued at USD %lld." // Format for company details
        static let companyTitle = "COMPANY"
        static let launchesTitle = "LAUNCHES"
    }

    // MARK: - Sort Order
    
    /// Constants related to sorting order options.
    struct SortOrder {
        static let ascending = "ASC"
        static let descending = "DESC"
    }

    // MARK: - Filter
    
    /// Constants related to filter options and placeholders.
    struct Filter {
        static let placeholder = "Enter Launch Year"
        static let success = "Success"
        static let failed = "Failed"
        static let all = "All"
        static let ascending = "Ascending"
        static let descending = "Descending"
        static let apply = "Apply"
        static let allYears = "All Years"
    }
    
    // MARK: - Table View
    
    /// Constants related to table view states and messages.
    struct TableView {
        static let noDataFound = "No Data Found" // Message when no data is available
    }
    
    // MARK: - Launch Detail
    
    /// Constants related to the launch detail screen.
    struct LaunchDetail {
        static let date = "Date"
        static let success = "Success"
        static let openWikipedia = "Open Wikipedia"
        static let watchOnYouTube = "Watch on YouTube"
        static let visitWebsite = "Visit Website"
        static let notAvailable = "N/A"
        static let description = "Description"
        static let actions = "Action"
        static let missionTitle = "Title"
        static let completed = "Successful"
        static let failed = "Failed"
        static let title = "Launch Detail"
    }
    
    // MARK: - Launch List
    
    /// Constants related to the launch list screen.
    struct LaunchList {
        static let days = "days"
    }
    
    // MARK: - YouTube
    
    /// Constants related to YouTube URLs.
    struct YouTube {
        static let url = "https://www.youtube.com/watch?v=" // Base URL for YouTube video links
    }
}
