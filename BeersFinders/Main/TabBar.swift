//
//  TabBar.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

struct TabBar: View {
    @State private var selection: Int = 1

    var body: some View {
        TabView(selection: $selection) {
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(0)
            SearchBeerView(viewModel: SearchBeerViewModel())
                .tabItem { Label("Search", systemImage: "magnifyingglass")}
                .tag(1)
        }
        .preferredColorScheme(.dark)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
