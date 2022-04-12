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
    @Published var detectedText: String?
    
    private(set) var title = "Search 🍺"
    private var cancellable = Set<AnyCancellable>()

    private let ocrService: OCRServiceDescriptor = OCRService()
    private let apiService: APIService = APIService()
    
    init() {
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
            self?.detectedText = detection.joined(separator: " ")
            self?.isLoading = false
        }
    }
    
    func fetchResult() {
        // TODO: - 1 DetectText from picked Image
        $pickedImageData.sink { [self] data in
            debugPrint("\(String(describing: data))")
            if let dataImage = data?.data {
                self.detectText(in: dataImage)
                print(self.detectedText)
                let test = UITextChecker().guesses(forWordRange: NSRangeFromString(self.detectedText!) , in: self.detectedText ?? "", language: "en")
                print(test)
            }
        }.store(in: &cancellable)
        
        // TODO: - 2 Call API
        print(detectedText)
        
    }
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
