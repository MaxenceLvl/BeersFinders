//
//  SearchBeerViewModel.swift
//  BeersFinders
//
//  Created by Louis Cauret on 09/04/2022.
//

import Foundation
import Combine
import UIKit

@MainActor
class SearchBeerViewModel: ObservableObject {
    @Published var beers: [BeerViewModel] = []
    @Published var showPicker = false
    @Published var pickedImageData: ImageData?
    @Published var isLoading: Bool = false
    @Published var detectedText: [String] = []
    
    private(set) var title = "Search 🍺"
    private var cancellable = Set<AnyCancellable>()
    
    private let ocrService: OCRServiceDescriptor = OCRService()
    private let apiService: APIService = APIService()
    
    init() {
        $pickedImageData.sink { image in
            Task {
                try await self.fetchResult()
            }
        }.store(in: &cancellable)
        
        Task {
            await search(name: "")
        }
    }
    
    func search(name: String) async {
        do {
            let beers = try await apiService.fetchBeerResults(with: name)
            self.beers = beers.map(BeerViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func detectText(in imageData: Data) {
        isLoading = true
        ocrService.detectText(in: imageData) { [weak self] detection in
            self?.detectedText = detection
            self?.isLoading = false
        }
    }
    
    func fetchResult() async throws {
        // MARK: - 1 DetectText from picked Image
        $pickedImageData.sink { [self] data in
            debugPrint("\(String(describing: data))")
            if let dataImage = data?.data {
                self.detectText(in: dataImage)
            }
        }.store(in: &cancellable)
        
        // MARK: - 2 Call API
        print(self.detectedText)
        self.beers.removeAll()
        let beers: [[Beer]] = try await withThrowingTaskGroup(of: [Beer].self, body: { group in
            var beerResult = [[Beer]]()
            detectedText.forEach { text in
                group.addTask {
                    return try await self.apiService.fetchBeerResults(with: text)
                }
            }
            for try await b in group {
                beerResult.append(b)
            }
            return beerResult
        })
        
        let res = beers.flatMap { $0 }
        let beersRes = Array(Set(res))
        
        let sortedBeers = beersRes.map { beer -> BeerMatch in
            let count = detectedText.reduce(0) { partialResult, text in
                return beer.displayName!.contains(text) ? partialResult + 1 : partialResult
            }
            print(count)
            return BeerMatch(beer: beer, numberOfMatch: count)
        }
            .sorted { $0.numberOfMatch < $1.numberOfMatch }
            .map { $0.beer }
        self.beers = sortedBeers.map(BeerViewModel.init)
    }
    
//    func flag(country:String) -> String {
//        let base : UInt32 = 127397
//        var flag = ""
//        for v in country.unicodeScalars {
//            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
//        }
//        return flag
//    }
//
//    func getCountryCode (_ countryDigit : String) -> String {
//        if let key = country.countryDictionary.first(
//            where: { $0.value == countryDigit })?.key {
//            return key
//        }
//        return ""
//    }
}

struct BeerMatch {
    
    let beer: Beer
    
    var numberOfMatch: Int
}

struct BeerViewModel {
    
    let beer: Beer
    
    var id: String? {
        beer.id
    }
    
    var title: String? {
        beer.displayName
    }
    
    var image: URL? {
        return beer.profileImage == nil ? nil : URL(string: beer.profileImage!)
    }
}
