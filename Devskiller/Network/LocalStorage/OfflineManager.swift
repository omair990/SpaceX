//
//  OfflineManager.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import CoreData

/// OfflineManager handles data management tasks related to offline storage using Core Data.
class OfflineManager {
    
    // MARK: - Properties
    private let coreDataService = CoreDataService.shared

    // MARK: - Company Data Management

    /// Clears all company data from Core Data.
    /// - Parameter completion: A closure that is called with the result of the operation.
    func clearCompanyData(completion: @escaping (Result<Void, Error>) -> Void) {
        executeBatchDelete(for: CoreDataConstants.Entities.companyCoreDataModel, completion: completion)
    }

    /// Fetches company data from Core Data.
    /// - Parameter completion: A closure that is called with the result of the fetch operation.
    func fetchCompanyData(completion: @escaping (Result<CompanyResponseModel?, Error>) -> Void) {
        fetchData(fetchRequest: CompanyCoreDataModel.fetchRequest()) { (result: Result<[CompanyCoreDataModel], Error>) in
            switch result {
            case .success(let companies):
                completion(.success(companies.first?.toCompanyResponseModel()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Saves company data to Core Data after clearing existing data.
    /// - Parameter company: The company data to save.
    /// - Parameter completion: A closure that is called with the result of the save operation.
    func saveCompanyData(company: CompanyResponseModel, completion: @escaping (Result<Void, Error>) -> Void) {
        performSaveOperation { [weak self] in
            guard let self = self else { return } // Safely unwrap self to avoid retain cycles
            
            self.clearCompanyData { result in
                switch result {
                case .success():
                    let companyEntity = CompanyCoreDataModel(context: self.coreDataService.context)
                    companyEntity.updateCompanyInfo(with: company)
                    
                    do {
                        try self.coreDataService.context.save() // Save the context after updating the entity
                        completion(.success(()))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - Launch Data Management

    /// Clears all launch data from Core Data.
    /// - Parameter completion: A closure that is called with the result of the operation.
    func clearLaunchData(completion: @escaping (Result<Void, Error>) -> Void) {
        executeBatchDelete(for: CoreDataConstants.Entities.launchCoreDataModel, completion: completion)
    }

    /// Fetches launch data from Core Data.
    /// - Parameter completion: A closure that is called with the result of the fetch operation.
    func fetchLaunchData(completion: @escaping (Result<[LaunchModel], Error>) -> Void) {
        fetchData(fetchRequest: LaunchCoreDataModel.fetchRequest()) { (result: Result<[LaunchCoreDataModel], Error>) in
            switch result {
            case .success(let launches):
                let launchModels = launches.map { $0.toLaunchModel() }
                completion(.success(launchModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Saves launch data to Core Data after clearing existing data, ensuring no duplicates.
    /// - Parameter launches: The list of launches to save.
    /// - Parameter completion: A closure that is called with the result of the save operation.
    func saveLaunchData(launches: [LaunchModel], completion: @escaping (Result<Void, Error>) -> Void) {
        performSaveOperation { [weak self] in
            guard let self = self else { return }
            
            self.clearLaunchData { result in
                switch result {
                case .success():
                    launches.forEach { launchData in
                        // Check if a launch with the same ID or date already exists
                        if !self.doesLaunchExist(id: launchData.id, date: launchData.date_utc) {
                            let launchEntity = LaunchCoreDataModel(context: self.coreDataService.context)
                            launchEntity.updateLaunchInfo(with: launchData)
                        }
                    }
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - Helper Methods

    /// Checks if a launch with a given ID or date already exists in Core Data.
    /// - Parameters:
    ///   - id: The ID of the launch.
    ///   - date: The date of the launch.
    /// - Returns: A boolean indicating if the launch already exists.
    private func doesLaunchExist(id: String?, date: String?) -> Bool {
        let context = coreDataService.context
        let fetchRequest: NSFetchRequest<LaunchCoreDataModel> = LaunchCoreDataModel.fetchRequest()
        
        // Create predicates to check if a launch with the same ID or date exists
        var predicates: [NSPredicate] = []
        if let id = id, !id.isEmpty {
            predicates.append(NSPredicate(format: "id == %@", id))
        }
        if let date = date, !date.isEmpty {
            predicates.append(NSPredicate(format: "date_utc == %@", date))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        do {
            let existingLaunches = try context.fetch(fetchRequest)
            return !existingLaunches.isEmpty
        } catch {
            print(AppConstants.ErrorMessages.fetchLaunchesFailed.localized() + ": \(error.localizedDescription)")
            return false
        }
    }

    /// Executes a batch delete request for a given entity.
    /// - Parameters:
    ///   - entityName: The name of the entity to delete.
    ///   - completion: A closure that is called with the result of the operation.
    private func executeBatchDelete(for entityName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = coreDataService.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(OfflineManagerError.dataClearError("\(AppConstants.ErrorMessages.clearDataFailed.localized()): \(error.localizedDescription)")))
        }
    }

    /// Performs a save operation within a perform block, ensuring context is saved afterward.
    /// - Parameter operation: A closure that contains the operations to perform.
    private func performSaveOperation(_ operation: () throws -> Void) {
        let context = coreDataService.context
        do {
            try operation()
            try context.save()
        } catch {
            print(OfflineManagerError.dataSaveError(AppConstants.ErrorMessages.saveError.localized() + ": \(error.localizedDescription)").localizedDescription)
        }
    }

    /// Fetches data using a given fetch request and returns the result via completion.
    /// - Parameters:
    ///   - fetchRequest: The fetch request to execute.
    ///   - completion: A closure that is called with the result of the fetch operation.
    private func fetchData<T: NSFetchRequestResult>(fetchRequest: NSFetchRequest<T>, completion: @escaping (Result<[T], Error>) -> Void) {
        let context = coreDataService.context
        do {
            let result = try context.fetch(fetchRequest)
            completion(.success(result))
        } catch {
            completion(.failure(OfflineManagerError.dataFetchError("\(AppConstants.ErrorMessages.fetchDataFailed.localized()): \(error.localizedDescription)")))
        }
    }
}
