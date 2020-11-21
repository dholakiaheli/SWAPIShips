//
//  StarshipController.swift
//  SWAPIShips
//
//  Created by Austin Goetz on 11/20/20.
//

import Foundation

class StarshipController {
    
    // https://swapi.dev/api/starships/
    private static let baseURL = URL(string: "https://swapi.dev/api/")
    private static let starshipsComponentString = "starships"
    private static let searchQueryString = "search"
    
    static func fetchStarships(with searchTerm: String, completion: @escaping (Result <[Starship], StarshipError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.unableToUnwrap)) }
        let starshipsURL = baseURL.appendingPathComponent(starshipsComponentString)
        var components = URLComponents(url: starshipsURL, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: searchQueryString, value: searchTerm)
        
        components?.queryItems = [searchQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.unableToUnwrap)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.apiError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(topLevelObject.results))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func getFilms(with filmURL: String, completion: @escaping (Result<Film, StarshipError>) -> Void) {
        guard let url = URL(string: filmURL) else { return completion(.failure(.unableToUnwrap)) }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.apiError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let film = try JSONDecoder().decode(Film.self, from: data)
                completion(.success(film))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
