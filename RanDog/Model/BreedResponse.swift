//
//  BreedResponse.swift
//  RanDog
//
//  Created by Ricardo Bravo on 24/06/21.
//

import Foundation

struct BreedResponse: Codable {
    let status: String
    let message: [String : [String]]
}
