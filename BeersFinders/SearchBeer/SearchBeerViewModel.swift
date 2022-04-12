//
//  SearchBeerViewModel.swift
//  BeersFinders
//
//  Created by Louis Cauret on 09/04/2022.
//

import Foundation

@MainActor
class SearchBeerViewModel: ObservableObject {
    
    @Published var beers: [BeerViewModel] = []
    
    func search(name: String) async {
        do {
            let beers = try await Connection().getBeers(searchTerm: name)
            self.beers = beers.map(BeerViewModel.init)
            
        } catch {
            print(error)
        }
    }
    
}

struct BeerViewModel {
    
    let beer: Beer
    
    var id: String? {
        beer.id
    }
    
    var title: String? {
        beer.displayName
    }
    
    var image: URL? {
        URL(string: beer.profileImage)
    }
}
