//
//  CoreDataStack.swift
//  BeersFinders
//
//  Created by Louis Cauret on 26/04/2022.
//

import CoreData

final class CoreDataStack {

    // MARK: - Singleton

   static let sharedInstance = CoreDataStack()

   // MARK: - Public

   var myProperty: AnyObject? // <--- Propriété exemple
    
    // MARK: - Private

    private lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "BeersFinder")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
    // MARK: - Public

      var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
      }
}
