//
//  SearchBeerViewModel.swift
//  BeersFinders
//
//  Created by Louis Cauret on 09/04/2022.
//

import Foundation
import Combine

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
    private let apiService: APICall = APICall()


    func search(name: String) async {
        do {
            let beers = try await Connection().getBeers(searchTerm: name)
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
        $pickedImageData.sink { data in
            debugPrint("\(data)")
            if let dataImage = data?.data {
                self.detectText(in: dataImage)
            }
        }.store(in: &cancellable)
        
        // TODO: - 2 Call API
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
        URL(string: beer.profileImage)
    }
}
