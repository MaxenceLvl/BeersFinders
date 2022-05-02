//
//  BeerFav+CoreDataProperties.swift
//  BeersFinders
//
//  Created by Louis Cauret on 26/04/2022.
//
//

import Foundation
import CoreData


extension BeerFav {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeerFav> {
        return NSFetchRequest<BeerFav>(entityName: "BeerFav")
    }

    @NSManaged public var id: String?

}

extension BeerFav : Identifiable {

}
