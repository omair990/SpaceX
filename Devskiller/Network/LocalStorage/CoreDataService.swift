//
//  CoreDataService.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import CoreData

/// CoreDataService handles the Core Data stack setup and management.
class CoreDataService {
    
    // MARK: - Singleton Instance
    static let shared = CoreDataService()
    
    // MARK: - Private Initializer
    private init() {}
    
    // MARK: - Persistent Container
    /// The persistent container for the Core Data stack.
    /// This container is used to manage the Core Data model and persistent store.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataConstants.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(AppConstants.ErrorMessages.loadError) \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Managed Object Context
    /// The managed object context tied to the main queue (UI).
    /// This context is used for performing fetches and updates on the main thread.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving Support
    /// Saves the context if there are any changes.
    /// If saving fails, it triggers a fatal error with details.
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("\(AppConstants.ErrorMessages.saveError) \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
