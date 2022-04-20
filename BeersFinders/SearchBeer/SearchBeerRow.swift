//
//  BeerRow.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 09/03/2022.
//

import SwiftUI

struct SearchBeerRow: View {
    
    let beerUrl: URL?
    let name: String?
    let alcohol: Int?
    
    var body: some View {
        HStack(spacing: 5) {
            if let url = beerUrl {
                AsyncImage(url: url, content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                },
                           placeholder: {
                    ProgressView()
                })
            } else {
                Image("empty_beer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            }
 
            VStack(alignment: .leading, spacing: 0) {
                if let beerName = name {
                    Text(beerName)
                        .font(.system(size: 18, weight: .bold))
                }
                if let alc = alcohol {
                    Text("\(alc/100)%")
                }
                Spacer()
            }
        }
    }
}


struct SearchBeerRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeerRow(beerUrl: URL(string: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1534164220/jc4ztekwrgvwglud6xqi.png"),
                      name: "Leffe Ambrée", alcohol: 700
        )
    }
}
