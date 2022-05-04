//
//  BeerDetailsViewModel.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 03/05/2022.
//

import Foundation

class BeerDetailsViewModel: ObservableObject {
    
    @Published var favoritesBeer: Beer
    @Published var isAdded = false
    
    init(with beer: Beer) {
        favoritesBeer = beer
    }
    
    func addBeerFav() {
        let res = DBService.shared.addFavBeer(with: favoritesBeer)
        
        switch res {
        case .failure: return
        case .success(let success): self.isAdded = success
        }
    }
    
    func removeBeerFav() {
        let res = DBService.shared.removeFavBeer(with: favoritesBeer)
        
        switch res {
        case .failure: return
        case .success(let success): self.isAdded = success
        }
    }
    
}

class BeerDetailsCoreViewModel: ObservableObject {
    @Published var favoritesBeer: Beers
    @Published var isAdded = false
    
    init(with beer: Beers) {
        favoritesBeer = beer
    }
    
    func removeBeerFav(with beer: Beers) {
        let res = DBService.shared.removeFromFav(by: beer.objectID)
        
        switch res {
        case .failure: return
        case .success(let success): self.isAdded = success
        }
    }
}
