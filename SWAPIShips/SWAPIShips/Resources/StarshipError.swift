//
//  StarshipError.swift
//  SWAPIShips
//
//  Created by Heli Bavishi on 11/21/20.
//

import Foundation

enum StarshipError: LocalizedError {
    case unableToUnwrap
    case apiError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .unableToUnwrap:
            return "Unable to unwrap."
        case .apiError(let error):
            return error.localizedDescription
        case .noData:
            return "We appear to have no data."
        case .unableToDecode:
            return "We were unable to decode our data."
        }
    }
}
