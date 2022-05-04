//
//  SearchBeerView.swift
//  BeersFinders
//
//  Created by Louis Cauret on 23/03/2022.
//

import SwiftUI

struct SearchBeerView: View {
    @ObservedObject private var viewModel: SearchBeerViewModel
    
    init(viewModel: SearchBeerViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.beers, id: \.id) { beer in
                let beerDetailViewModel = BeerDetailsViewModel(with: beer.beer)
                NavigationLink(destination: BeerDetails(vm: beerDetailViewModel)) {
                    SearchBeerRow(beerUrl: beer.image, name: beer.title,
                                  alcohol: beer.beer.alcohol,
                                  countryCode: beer.beer.brewery?.country,
                                  breweryName: beer.beer.brewery?.name,
                                  beerType: beer.beer.beerType
                    )
                }
            }.listStyle(.plain)
                .navigationTitle(viewModel.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showPicker = true
                        } label: {
                            Image(systemName: "camera.fill")
                        }
                    }
                }
                .fullScreenCover(isPresented: $viewModel.showPicker) {
                    ImagePickerView(data: $viewModel.pickedImageData)
                        .edgesIgnoringSafeArea(.all)
                }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { value in
            Task.init {
                if !value.isEmpty && value.count > 2 {
                    await viewModel.search(name: value)
                } else {
                    viewModel.beers.removeAll()
                }
            }
        }
    }
}
