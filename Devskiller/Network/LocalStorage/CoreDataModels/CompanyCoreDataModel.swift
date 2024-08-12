//
//  CompanyCoreDataModel.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import CoreData

/// Core Data entity for storing company data.
@objc(CompanyCoreDataModel)
public class CompanyCoreDataModel: NSManagedObject {

    // MARK: - Core Data Properties
    
    @NSManaged public var name: String?
    @NSManaged public var founder: String?
    @NSManaged public var founded: Int64
    @NSManaged public var employees: Int64
    @NSManaged public var launchSites: Int64
    @NSManaged public var valuation: Int64
    @NSManaged public var id: String?

    // MARK: - Fetch Request
    
    /// Fetch request for retrieving CompanyCoreDataModel objects.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyCoreDataModel> {
        return NSFetchRequest<CompanyCoreDataModel>(entityName: CoreDataConstants.Entities.companyCoreDataModel)
    }
    
    // MARK: - Convenience Methods
    
    /// Updates the Core Data entity with data from a `CompanyResponseModel` object.
    /// - Parameter model: The `CompanyResponseModel` object containing the new data.
    public func updateCompanyInfo(with model: CompanyResponseModel) {
        self.name = model.name
        self.founder = model.founder
        self.founded = Int64(model.founded)
        self.employees = Int64(model.employees)
        self.launchSites = Int64(model.launchSites)
        self.valuation = Int64(model.valuation)
        self.id = model.id
    }
    
    /// Converts the Core Data entity to a `CompanyResponseModel` object.
    /// - Returns: A `CompanyResponseModel` object representing the current Core Data entity.
    public func toCompanyResponseModel() -> CompanyResponseModel {
        return CompanyResponseModel(
            name: self.name ?? "",
            founder: self.founder ?? "",
            founded: Int(self.founded),
            employees: Int(self.employees),
            launchSites: Int(self.launchSites),
            valuation: self.valuation,
            id: self.id ?? ""
        )
    }
}
