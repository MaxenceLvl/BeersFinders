//
//  BeersFindersApp.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

@main
struct BeersFindersApp: App {
    let persistenceController = DBService.shared

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
    }
}
