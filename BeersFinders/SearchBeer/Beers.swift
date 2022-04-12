//
//  Beers.swift
//  BeersFinders
//
//  Created by Louis Cauret on 11/04/2022.
//

import Foundation

struct BeerResult: Codable {
    let beers: [Beer]
    let count: Int
    let beersInDatabase: Int
}

struct Beer: Codable {
    let id: String?
    let IBU: Int?
    let alcohol: Int?
    let beerType: String?
    let description: String?
    let displayName: String?
    let fermentation: String?
    let typeFamily: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case description = "int_description"
        case profileImage = "_id"
        
        case id
        case IBU
        case alcohol
        case beerType
        case fermentation
        case typeFamily
    }
}