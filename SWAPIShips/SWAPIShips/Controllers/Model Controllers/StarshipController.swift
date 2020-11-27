//
//  StarshipController.swift
//  SWAPIShips
//
//  Created by Heli Bavishi on 11/21/20.
//

import Foundation

// "https://swapi.dev/api/starships/?search={searchTerm}

class StarshipController {
    
    private static let baseURLString = "https://swapi.dev/api/"
    private static let starshipsComponentString = "starships"
    private static let searchQueryString = "search"
   
    static func fetchStarships(with searchTerm: String, completion: @escaping (Result<[Starship],StarshipError>) -> Void) {
        
        //Construct the final URL
        //Create baseURL
        guard let baseURL = URL(string: baseURLString) else { return completion(.failure(.unableToUnwrap))}
        //Add starships component
        let starshipsURL = baseURL.appendingPathComponent(starshipsComponentString)
        //Break URL into components
        var components = URLComponents(url: starshipsURL, resolvingAgainstBaseURL: true)
        //Define search query item
        let searchQuery = URLQueryItem(name: searchQueryString, value: searchTerm)
        components?.queryItems = [searchQuery]
        //create finalURL from components
        guard let finalURL = components?.url else { return completion(.failure(.unableToUnwrap))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // 1 - Handle the error if there is one
            if let error = error {
                print(error)
                print(error.localizedDescription)
                return completion(.failure(.apiError(error)))
            }
            // 2 - Check the data
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion (.success(topLevelObject.results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchFilm(with filmURL: String, completion: @escaping (Result<Film, StarshipError>) -> Void) {
        guard let url = URL(string: filmURL) else { return completion(.failure(.unableToUnwrap)) }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            // Handle error
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.apiError(error)))
            }
            // Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            // Decode objects
            do {
                let film = try JSONDecoder().decode(Film.self, from: data)
                completion(.success(film))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
