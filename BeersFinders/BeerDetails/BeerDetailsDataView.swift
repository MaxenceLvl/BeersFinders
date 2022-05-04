//
//  BeerDetailsDataView.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 04/05/2022.
//

import SwiftUI
import IsoCountryCodes

struct BeerDataDetails: View {
    
    @ObservedObject private var viewModel: BeerDetailsCoreViewModel
    
    init(vm: BeerDetailsCoreViewModel) {
        self.viewModel = vm
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing: 0){
                if let beerName = viewModel.favoritesBeer.name {
                    Text(beerName)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 30, weight: .bold))
                        .padding(.bottom, 12)
                }
                HStack(spacing: 0) {
                    Spacer()
                    if let url = viewModel.favoritesBeer.image {
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
                        Image("bier")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 10)
                    }
                    Spacer()
                }
                if let country = viewModel.favoritesBeer.brewery?.country, let flag = IsoCountryCodes.find(key: country)?.flag {
                    HStack(spacing: 0) {
                        Spacer()
                        Text("Origines : ")
                            .font(.system(size: 18, weight: .bold))
                        Text(flag)
                            .font(.system(size: 28))
                            .padding(.top, 5)
                            .padding(.trailing, 7)
                        Spacer()
                    }
                }
                HStack(spacing: 0){
                    if let alc = viewModel.favoritesBeer.alcohol {
                        Text("Alcohol : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(alc/100)%")
                        Spacer()
                    } else {
                        Text("Alcohol : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("NC")
                    }
                    if let ibu = viewModel.favoritesBeer.ibu {
                        Text("IBU : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(ibu)")
                    } else {
                        Text("IBU : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("NC")
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 10)
                if let beerType = viewModel.favoritesBeer.type {
                    HStack(spacing: 0){
                        Text("Beer Type : ")
                            .font(.system(size: 18, weight: .bold))
                            .lineLimit(1)
                        Text("\(beerType)")
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 10)
                }
                if let fermentation = viewModel.favoritesBeer.fermentation {
                    HStack(spacing: 0){
                        
                        Text("Fermentation : ")
                            .font(.system(size: 18, weight: .bold))
                            .lineLimit(1)
                        Text(LocalizedStringKey(fermentation))
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 10)
                }
                if let fType = viewModel.favoritesBeer.family {
                    HStack(spacing: 0){
                        
                        Text("Family Type : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("\(fType)")
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 10)
                }
                if let description = viewModel.favoritesBeer.beerDescription {
                    Text("Description : ")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 16)
                        .padding(.horizontal, 10)
                    Text(description)
                        .padding(.top, 4)
                        .padding(.horizontal, 10)
                } else {
                    HStack(spacing: 0){
                        Text("Description : ")
                            .font(.system(size: 18, weight: .bold))
                        Text("No description")
                            .padding(.horizontal, 7)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 10)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if (viewModel.isAdded || viewModel.favoritesBeer.isFavorite) {
                        viewModel.removeBeerFav(with: viewModel.favoritesBeer)
                    }
                } label: {
                    if (viewModel.isAdded || viewModel.favoritesBeer.isFavorite) {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
            }
        }
    }
}

//struct BeerDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        BeerDetails(beer: Beer(id: "aezr", IBU: 25, alcohol: 75, beerType: "Ambrée", description: "OUAIS OUAIS", displayName: "Leffe Ambré", fermentation: "Fermentation basse", typeFamily: "Biere", profileImage: "https://res.cloudinary.com/dzt4ytngw/image/upload/v1534164220/jc4ztekwrgvwglud6xqi.png", brewery: Brewery(country: "USA", name: "Leffe")))
//    }
//}

