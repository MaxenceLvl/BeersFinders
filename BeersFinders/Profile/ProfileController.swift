//
//  ProfileController.swift
//  BeersFinders
//
//  Created by Louis Cauret on 27/04/2022.
//

import CoreData

struct ProfileController {
    
    static let shared = ProfileController()
    
    let container = NSPersistentContainer(name: "BeersFinders")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
