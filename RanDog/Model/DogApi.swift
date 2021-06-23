//
//  DogApi.swift
//  RanDog
//
//  Created by Ricardo Bravo on 23/06/21.
//

import Foundation

class DogApi {
    
    enum Endpoint: String {
        case randomImage = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
