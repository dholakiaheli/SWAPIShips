//
//  Starship.swift
//  SWAPIShips
//
//  Created by Heli Bavishi on 11/21/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Starship]
}

struct Starship: Decodable {
    let name: String
    let model: String
    let cost: String
    let speed: String
    let films : [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case cost = "cost_in_credits"
        case speed = "max_atmosphering_speed"
        case films
    }
}
