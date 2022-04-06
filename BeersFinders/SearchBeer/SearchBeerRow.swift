//
//  BeerRow.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 09/03/2022.
//

import SwiftUI

struct BeerRow: View {
    
    let urlString: String?
    
    var body: some View {
        HStack(spacing: 5) {
            if let url = urlString {
                AsyncImage(
                    url: URL(string: url),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 75, maxHeight: 150)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("World")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
        }
    }
}

struct SearchBeerRow_Previews: PreviewProvider {
    static var previews: some View {
        BeerRow(urlString: "")
    }
}
