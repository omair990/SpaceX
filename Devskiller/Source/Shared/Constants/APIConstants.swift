//
//  APIConstants.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// APIConstants contains constants used for API configurations and endpoints.
struct APIConstants {
    
    // MARK: - Base URL
    
    /// Constants related to the base URL of the API.
    struct BaseURL {
        static let production = "https://api.spacexdata.com/v4" // Production base URL
    }
    
    // MARK: - Endpoints
    
    /// Constants related to the specific API endpoints.
    struct Endpoints {
        static let companyInfo = "/company" // Endpoint to fetch company information
        static let allLaunches = "/launches/query" // Endpoint to query all launches
        static let launchDetail = "/launches" // Base endpoint for fetching launch details
    }
    
    // MARK: - HTTP Methods
    
    /// Constants related to the HTTP methods used in API requests.
    struct HTTPMethods {
        static let get = "GET" // GET method for fetching data
        static let post = "POST" // POST method for submitting data
    }
    
    // MARK: - Headers
    
    /// Constants related to HTTP headers used in API requests.
    struct Headers {
        static let contentType = "Content-Type" // Header for content type
        static let contentTypeJSON = "application/json" // Value for JSON content type
    }
    
    // MARK: - Query Parameters
    
    /// Constants related to query parameters used in API requests.
    struct QueryParameters {
        static let limit = 10 // Default limit for query results
        static let asc = "asc" // Ascending order parameter
        static let desc = "desc" // Descending order parameter
        static let rocket = "rocket" // Query parameter for filtering by rocket
    }
}
