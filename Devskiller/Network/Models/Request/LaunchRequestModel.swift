//
//  LaunchRequestModel.swift
//  Devskiller
//
//  Created by OCIT-MAC on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

/// Model representing the request payload for fetching launches.
class LaunchRequestModel: Codable {
    
    // MARK: - Properties
    var query: Query?
    var options: DataOptions?
    
    // MARK: - Query Model
    
    /// Represents the query parameters for the request.
    class Query: Codable {
        var dateUTC: DateRange?
        var success: Bool?
        
        /// Represents a date range with greater than or equal to (gte) and less than or equal to (lte) values.
        class DateRange: Codable {
            var gte: String?
            var lte: String?
            
            enum CodingKeys: String, CodingKey {
                case gte = "$gte"
                case lte = "$lte"
            }
            
            init(gte: String? = nil, lte: String? = nil) {
                self.gte = gte
                self.lte = lte
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case dateUTC = "date_utc"
            case success
        }
        
        init(dateUTC: DateRange? = nil, success: Bool? = nil) {
            self.dateUTC = dateUTC
            self.success = success
        }
    }
    
    // MARK: - DataOptions Model
    
    /// Represents the options for data manipulation, such as pagination, sorting, and population of related fields.
    class DataOptions: Codable {
        var populate: [Populate]?
        var sort: Sort?
        var page: Int?
        var limit: Int?
        
        /// Represents the population options for nested resources.
        class Populate: Codable {
            var path: String?
            var select: Select?
            
            /// Specifies which fields of the nested resources should be returned.
            class Select: Codable {
                var name: Int?
                var type: Int?
                
                init(name: Int? = nil, type: Int? = nil) {
                    self.name = name
                    self.type = type
                }
            }
            
            init(path: String? = nil, select: Select? = nil) {
                self.path = path
                self.select = select
            }
        }
        
        /// Represents the sorting options for the data.
        class Sort: Codable {
            var dateUTC: String?
            
            enum CodingKeys: String, CodingKey {
                case dateUTC = "date_utc"
            }
            
            init(dateUTC: String? = nil) {
                self.dateUTC = dateUTC
            }
        }
        
        init(populate: [Populate]? = nil, sort: Sort? = nil, page: Int? = nil, limit: Int? = nil) {
            self.populate = populate
            self.sort = sort
            self.page = page
            self.limit = limit
        }
    }
    
    // MARK: - Initializer
    
    init(query: Query? = nil, options: DataOptions? = nil) {
        self.query = query
        self.options = options
    }
}

// MARK: - DataOptions Extension

/// Extension to easily configure `DataOptions`.
extension LaunchRequestModel.DataOptions {
    
    func withPage(_ page: Int) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: self.sort, page: page, limit: self.limit)
    }
    
    func withLimit(_ limit: Int) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: self.sort, page: self.page, limit: limit)
    }
    
    func withPopulate(_ populate: [LaunchRequestModel.DataOptions.Populate]) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: populate, sort: self.sort, page: self.page, limit: self.limit)
    }
    
    func withSort(_ sort: LaunchRequestModel.DataOptions.Sort?) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: sort, page: self.page, limit: self.limit)
    }
}
