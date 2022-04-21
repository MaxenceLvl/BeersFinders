//
//  BeerRow.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 09/03/2022.
//

import SwiftUI
import IsoCountryCodes

struct SearchBeerRow: View {
    
    let beerUrl: URL?
    let name: String?
    let alcohol: Int?
    let countryCode: String?
    let breweryName: String?
    let beerType: String?
    
    var body: some View {
        HStack(spacing: 5) {
            if let url = beerUrl {
                AsyncImage(url: url, content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                        .padding(.vertical, 10)
                },
                           placeholder: {
                    ProgressView()
                })
            } else {
                Image("empty_beer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .padding(.vertical, 10)
            }
            VStack(alignment: .leading) {
                if let beerName = name {
                    Text(beerName)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.vertical, 10)
                        .padding(.leading, 2)
                }
                HStack(spacing: 0) {
                    if let alc = alcohol {
                        Text("\(alc/100)%")
                    }
                    if let beerType = beerType {
                        Text(" - \(beerType)")
                            .lineLimit(1)
                    }
                }
                HStack(spacing: 0) {
                    if let country = countryCode,
                       let flag = IsoCountryCodes.find(key: country)?.flag {
                        Text(flag)
                            .padding(.top, 5)
                            .padding(.trailing, 7)
                    }
                    if let breweryName = breweryName {
                        Text(breweryName)
                            .padding(.top, 5)
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}


struct SearchBeerRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeerRow(beerUrl: URL(string: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1534164220/jc4ztekwrgvwglud6xqi.png"),
                      name: "Leffe Ambrée", alcohol: 700, countryCode: "USA", breweryName: "Leffe", beerType: "Belgian Amber"
        )
    }
}
