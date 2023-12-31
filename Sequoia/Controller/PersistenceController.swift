//
//  PersistenceController.swift
//  Sequoia
//
//  Created by Saravana Rathinam on 12/29/23.
//

import CoreData

class PersistentController {
    static let shared = PersistentController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print("Unresolved error in Persistence Controller \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func clearAllData() {
        #if DEBUG
        print("Clearing all data ...")
        let entities = container.managedObjectModel.entities
        entities.forEach { entity in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try container.viewContext.execute(deleteRequest)
            } catch let error as NSError {
                print("Error clearing data for entity \(entity.name!): \(error), \(error.userInfo)")
            }
        }
        #else
        print("ERROR: Clear all data called in Production code!")
        #endif
    }

}
