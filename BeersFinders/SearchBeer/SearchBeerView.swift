//
//  SearchBarView.swift
//  BeersFinders
//
//  Created by Louis Cauret on 23/03/2022.
//

import SwiftUI

struct SearchBeerView: View {
    @StateObject private var beerListVM = SearchBeerViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List(beerListVM.beers, id: \.id) { beer in
                HStack {
                    AsyncImage(url: beer.image
                               , content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50)
                    }, placeholder: {
                        ProgressView()
                    })
                    Text(beer.title!)
                }
            }.listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText) { value in
                    Task.init {
                        if !value.isEmpty &&  value.count > 3 {
                            await beerListVM.search(name: value)
                        } else {
                            beerListVM.beers.removeAll()
                        }
                    }
                }.navigationTitle("Beers")
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeerView()
    }
}
