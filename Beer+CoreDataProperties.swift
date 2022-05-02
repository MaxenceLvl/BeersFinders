//
//  Beer+CoreDataProperties.swift
//  BeersFinders
//
//  Created by Louis Cauret on 26/04/2022.
//
//

import Foundation
import CoreData


extension Beer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beer> {
        return NSFetchRequest<Beer>(entityName: "Beer")
    }

    @NSManaged public var id: String?

}

extension Beer : Identifiable {

}
