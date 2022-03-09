//
//  CameraView.swift
//  BeersFinders
//
//  Created by Louis Cauret on 16/02/2022.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject private var viewModel = CameraViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
