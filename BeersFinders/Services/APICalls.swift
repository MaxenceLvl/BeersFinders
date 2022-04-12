//
//  APICalls.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 23/03/2022.
//

import Foundation

class APICall {
    
    var urlComponent: URLComponents
    var session: URLSession
    var request: URLRequest
    
    
    //TODO: - Faire le changement de name en fct du retour de vision
    init() {
        urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "beertasting.club"
        urlComponent.path = "/api/v5/beer"
        urlComponent.queryItems = [
            URLQueryItem(name: "name", value: "Leffe"),
            URLQueryItem(name: "skip", value: "0"),
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "sortType", value: "name"),
            URLQueryItem(name: "sortDirection", value: "asc")
        ]

        request = URLRequest(url: urlComponent.url!)
        request.setValue(
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
  
    enum NetworkError: Error {
        case invalidURL
        case parsingError
        case noData
    }
    
    func fetchBeerResults(completionHandler: @escaping (Result<[Beer], Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completionHandler(.failure(NetworkError.noData))
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let result = try jsonDecoder.decode(BeerResult.self, from: data)
                    let beerResults = result.beers.map { $0 }
                    completionHandler(.success(beerResults))
                } catch {
                    completionHandler(.failure(NetworkError.parsingError))
                }
            } else {
                completionHandler(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
}
