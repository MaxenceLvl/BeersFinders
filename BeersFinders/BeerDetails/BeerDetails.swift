//
//  BeerDetails.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 20/04/2022.
//

import SwiftUI

struct BeerDetails: View {
    
    let beer: Beer
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BeerDetails_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetails(beer: Beer(id: "aezr", IBU: 25, alcohol: 75, beerType: "Ambrée", description: "OUAIS OUAIS", displayName: "Leffe Ambré", fermentation: "Fermentation basse", typeFamily: "Biere", profileImage: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1534164220/jc4ztekwrgvwglud6xqi.png", brewery: Brewery(country: "USA", name: "Leffe")))
    }
}
