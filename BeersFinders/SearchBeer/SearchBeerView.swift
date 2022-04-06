//
//  BeersView.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

struct SearchBeerView: View {
    var body: some View {
        NavigationView {
            List {
                SearchBeerRow()
            }
            .navigationTitle("Search")
        }
        
    }
}

struct SearchBeerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeerView()
    }
}
