//
//  ProfileViewModel.swift
//  BeersFinders
//
//  Created by Louis Cauret on 20/04/2022.
//

import SwiftUI
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var favoriteBeers = [Beers]()
    @Published var user: User?
    
    init()
    {
        fetchFavoriteBeers()
        fetchUser()
    }
    
    func fetchFavoriteBeers() {
        let beerResult = DBService.shared.getBeers()
        switch beerResult {
        case    .failure: return
        case .success(let result): self.favoriteBeers = result
        }
    }
    
    func fetchUser() {
        let userResult = DBService.shared.getUser()
        switch userResult {
        case    .failure: return
        case .success(let result): self.user = result
        }
    }
}
