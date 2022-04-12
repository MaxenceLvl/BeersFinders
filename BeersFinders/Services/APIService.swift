//
//  APIService.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 23/03/2022.
//

import Foundation

class APIService {
    
    var session: URLSession
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    enum NetworkError: Error {
        case invalidURL
        case parsingError
        case noData
    }
    
    //MARK: - Création de l'URLComponent avec les Termes de recherches directement
    private func createUrlComponents(with searchTerms: String)-> URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "beertasting.club"
        urlComponent.path = "/api/v5/beer"
        urlComponent.queryItems = [
            URLQueryItem(name: "name", value: searchTerms.trimmed()),
            URLQueryItem(name: "skip", value: "0"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "sortType", value: "name"),
            URLQueryItem(name: "sortDirection", value: "asc")
        ]
        return urlComponent
    }
    
    //MARK: - Création de la request avec l'URLComponent
    private func urlRequest(from urlComponent: URLComponents)-> URLRequest {
        var request = URLRequest(url: urlComponent.url!)
        request.setValue(
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        return request
    }
    
    //MARK: - Récupération des résultats de la requête an tableau de Beer
    func fetchBeerResults(with searchTerm: String) async throws -> [Beer] {
        let urlComponent = createUrlComponents(with: searchTerm)
        let request = urlRequest(from: urlComponent)
        
        guard let (data, _) = try? await session.data(for: request) else {
            throw NetworkError.noData }
        
        do {
            let result = try JSONDecoder().decode(BeerResult.self, from: data)
            let beerResults = result.beers.map { $0 }
            return beerResults
        } catch {
            throw NetworkError.parsingError
        }
    }
}

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

