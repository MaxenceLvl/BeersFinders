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
        ScrollView{
            VStack(spacing: 0){
                if let beerName = beer.displayName {
                    Text(beerName)
                        .font(.system(size: 30, weight: .bold))
                        .padding(.bottom, 12)
                }
                if let url = beer.profileImage {
                    AsyncImage(url: URL(string: url), content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 10)
                    },
                               placeholder: {
                        ProgressView()
                    })
                } else {
                    Image("empty_beer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.vertical, 10)
                }
                HStack(spacing: 0){
                    if let alc = beer.alcohol {
                        Text("Alcohol : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(alc/100)%")
                    } else {
                        Text("Alcohol : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("NC")
                    }
                    Spacer()
                    if let beerType = beer.beerType {
                        Text("Type : ")
                            .font(.system(size: 18, weight: .bold))
                            .lineLimit(1)
                        Text("\(beerType)")
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 10)
                HStack(spacing: 0){
                    if let fermentation = beer.fermentation {
                        Text("Fermentation : ")
                            .font(.system(size: 18, weight: .bold))
                            .lineLimit(1)
                        Text(LocalizedStringKey(fermentation))
                        Spacer()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 10)
                HStack(spacing: 0){
                    if let ibu = beer.IBU {
                        Text("IBU : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(ibu)")
                        Spacer()
                    } else {
                        Text("IBU : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("NC")
                        Spacer()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 10)
                HStack(spacing: 0){
                    if let description = beer.description {
                        Text(description)
                            .padding(.horizontal, 7)
                            .background(Color.red)
                    }
                }
            }
        }
    }
}

struct BeerDetails_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetails(beer: Beer(id: "aezr", IBU: 25, alcohol: 75, beerType: "Ambrée", description: "OUAIS OUAIS", displayName: "Leffe Ambré", fermentation: "Fermentation basse", typeFamily: "Biere", profileImage: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1534164220/jc4ztekwrgvwglud6xqi.png", brewery: Brewery(country: "USA", name: "Leffe")))
    }
}
