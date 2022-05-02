//
//  Persistence.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import CoreData

struct DBService {
    static let shared = DBService()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BeersFinders")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //MARK: - Core Data to store Beer
    
    func getBeers() -> Result<[Beers], Error> {
        
        let fetchRequest = Beers.fetchRequest()
        let context = container.viewContext
        
        do {
            let beers = try context.fetch(fetchRequest)
            return .success(beers)
        } catch {
            return .failure(error)
        }
    }
    
    func getUser() -> Result<User?, Error> {
        
        let fetchRequest = User.fetchRequest()
        let context = container.viewContext
        
        do {
            let user = try context.fetch(fetchRequest).first
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    func addDefaultUser() {
        let userResult = getUser()
        let context = container.viewContext
        
        switch userResult {
        case .failure: return
        case .success(let user):
            if (user == nil) {
                let fakeUser = User(entity: User.entity(), insertInto: context)
                fakeUser.userAvatar = "avatar"
                fakeUser.userName = "Sascha"
                fakeUser.userPassword = "root"
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
