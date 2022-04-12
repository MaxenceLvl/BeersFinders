//
//  SearchBarView.swift
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
                }
                .navigationTitle("Beers")
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
            .onAppear {
                // TODO: - 1 -> fct pour fetch Result
                viewModel.fetchResult()
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchBeerViewModel()
        SearchBeerView(viewModel: viewModel)
    }
}
