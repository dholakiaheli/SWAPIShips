//
//  Starship.swift
//  SWAPIShips
//
//  Created by Austin Goetz on 11/20/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Starship]
}

struct Starship: Decodable {
    let name: String
    let model: String
    let cost: String
    let topSpeed: String
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case cost = "cost_in_credits"
        case topSpeed = "max_atmosphering_speed"
        case films
    }
}
