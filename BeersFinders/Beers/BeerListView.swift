//
//  BeersView.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

struct BeerListView: View {
    var body: some View {
        NavigationView {
            List {
                BeerRow(urlString: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1559315764/ljcahqwkq0vztkpm7j9y.png")
            }
            .navigationTitle("Search")
        }
        
    }
}

struct BeersListView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListView()
    }
}
