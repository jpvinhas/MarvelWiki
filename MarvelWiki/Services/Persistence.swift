//
//  Persistence.swift
//  MarvelWiki
//
//  Created by João Pedro Borges on 21/08/24.
//

import Foundation
import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController()
    
    private init() { }
    
    // Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarvelWiki") // Nome do modelo de dados
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // Core Data saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

