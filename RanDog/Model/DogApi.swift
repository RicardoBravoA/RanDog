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
    
    class func requestRandomImage(completionHandler: @escaping (DogResponse?, Error?) -> Void) {
        let randomImage = DogApi.Endpoint.randomImage.url
        let task = URLSession.shared.dataTask(with: randomImage) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(DogResponse.self, from: data)
                completionHandler(response, nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
