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
}
