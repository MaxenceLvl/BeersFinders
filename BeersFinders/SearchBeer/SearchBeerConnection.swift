//
//  SearchBeerConnection.swift
//  BeersFinders
//
//  Created by Louis Cauret on 11/04/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}

class Connection {
    
    func getBeers(searchTerm: String) async throws -> [Beer] {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "beertasting.club"
        components.path = "/api/v5/beer"
        components.queryItems = [
            URLQueryItem(name: "name", value: searchTerm.trimmed()),
            URLQueryItem(name: "skip", value: "0"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "sortType", value: "name"),
            URLQueryItem(name: "sortDirection", value: "asc")
        ]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        let beerResponse = try? JSONDecoder().decode(BeerResult.self, from: data)
        return beerResponse?.beers ?? []
    }
}

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
