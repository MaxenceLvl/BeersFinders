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
        let context = container.viewContext
        let predicate: NSPredicate = NSPredicate(format: "isFavorite = %d", true)
        let fetchRequest = Beers.fetchRequest()
        
        fetchRequest.predicate = predicate
        
        do {
            let beers = try context.fetch(fetchRequest)
            return .success(beers)
        } catch {
            return .failure(error)
        }
    }
    
    func getBreweries() -> Result<[Breweries], Error> {
        let context = container.viewContext
        let fetchRequest = Breweries.fetchRequest()
        
        do {
            let breweries = try context.fetch(fetchRequest)
            return .success(breweries)
        } catch {
            return .failure(error)
        }
    }
    
    func removeFavBeer(with beer: Beer) -> Result<Bool, Error> {
        let context = container.viewContext
        let beers = getBeers()
        switch beers {
        case .failure(let error): return .failure(error)
        case .success(let beerRes):
            if(beerRes.contains(where: { b in
                b.beerID == beer.id
            })) {
                if let beerCoreData = beerRes.first(where: { $0.beerID == beer.id }) {
                    do {
                        let beerToDelete = try context.existingObject(with: beerCoreData.objectID)
                        context.delete(beerToDelete)
                        return .success(true)
                    } catch {
                        print(error.localizedDescription)
                        return .failure(error)
                    }
                }
            }
        }
        return .success(false)
    }
    
    func removeFromFav(by id: NSManagedObjectID) -> Result<Bool, Error> {
        let context = container.viewContext
        
        do {
            let beer = try context.existingObject(with: id)
            beer.setValue(true, forKey: "isFavorite")
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func addFavBeer(with beer: Beer) -> Result<Bool, Error> {
        let context = container.viewContext
        let beers = getBeers()
        let breweries = getBreweries()
        
        switch beers {
        case .failure(let error): return .failure(error)
        case .success(let beerResult):
            switch breweries {
            case .failure(let error): return .failure(error)
            case .success(let breweryResult):
                let brewery = Breweries(entity: Breweries.entity(), insertInto: context)
                brewery.name = beer.brewery?.name
                brewery.country = beer.brewery?.country
                if(breweryResult.isEmpty) {
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                        return .failure(error)
                    }
                } else {
                    if(breweryResult.contains(where: { breweryRes in
                        breweryRes.name == beer.brewery?.name
                    })) {
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                            return .failure(error)
                        }
                    }
                }
                let favBeer = Beers(entity: Beers.entity(), insertInto: context)
                favBeer.beerID = beer.id!
                favBeer.name = beer.displayName
                favBeer.brewery = brewery
                favBeer.alcohol = (beer.alcohol == nil) ? 0 : Int64(beer.alcohol!)
                favBeer.fermentation = beer.fermentation
                favBeer.ibu = (beer.IBU == nil) ? 0 : Int64(beer.IBU!)
                favBeer.beerDescription = beer.description
                favBeer.image = beer.profileImage
                favBeer.type = beer.beerType
                favBeer.family = beer.typeFamily
                favBeer.isFavorite = true
                
                if(!beerResult.isEmpty) {
                    if(!beerResult.contains(where: { beerRes in
                        beerRes.name == beer.displayName
                    })) {
                        do {
                            try context.save()
                            return .success(true)
                        } catch {
                            print(error.localizedDescription)
                            return .failure(error)
                        }
                    }
                } else {
                    do {
                        try context.save()
                        return .success(true)
                    } catch {
                        print(error.localizedDescription)
                        return .failure(error)
                    }
                }
            }
        }
        return .success(true)
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
