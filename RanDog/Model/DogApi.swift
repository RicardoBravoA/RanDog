//
//  DogApi.swift
//  RanDog
//
//  Created by Ricardo Bravo on 23/06/21.
//

import Foundation
import UIKit

class DogApi {
    
    enum Endpoint: String {
        case randomImage = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImage(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let imageTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let image = UIImage(data: data)
            completionHandler(image, nil)
        }
        imageTask.resume()
    }
}
