//
//  ProfileView.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 16/02/2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        if let avatar = viewModel.user?.userAvatar {
                            Image(avatar).resizable()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 3))
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 250, maxHeight: 200)
                                .padding(50)
                        }
                    }
                    HStack {
                        Text("My favorite beers ⭐️")
                            .font(.system(size:20))
                            .foregroundColor(.yellow)
                            .padding(15)
                        Spacer()
                    }
                    // List of Fav Beers ForEach {}
                }
            }
            .navigationTitle(viewModel.user?.userName ?? "Profile")
        }
    }
}
