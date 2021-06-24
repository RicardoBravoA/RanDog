//
//  DogApi.swift
//  RanDog
//
//  Created by Ricardo Bravo on 23/06/21.
//

import Foundation
import UIKit

class DogApi {
    
    enum Endpoint {
        case randomImage
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
                case .randomImage:
                    return "https://dog.ceo/api/breeds/image/random"
                case .randomImageForBreed(let breed):
                    return "https://dog.ceo/api/breed/\(breed)/images/random"
                case .listAllBreeds:
                    return "https://dog.ceo/api/breeds/list/all"
            }
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
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogResponse?, Error?) -> Void) {
        let randomImage = DogApi.Endpoint.randomImageForBreed(breed).url
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
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let url = DogApi.Endpoint.listAllBreeds.url
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(BreedResponse.self, from: data)
                let breeds = response.message.keys.map({$0})
                completionHandler(breeds, nil)
            } catch {
                print(error)
                completionHandler([], error)
            }
        }
        task.resume()
    }
}
