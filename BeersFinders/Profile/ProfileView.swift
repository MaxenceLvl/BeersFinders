//
//  ProfileView.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Hello, Profile!")
                .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
