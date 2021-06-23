//
//  ViewController.swift
//  RanDog
//
//  Created by Ricardo Bravo on 23/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let randomImage = DogApi.Endpoint.randomImage.url
        let task = URLSession.shared.dataTask(with: randomImage) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(DogResponse.self, from: data)
                
                guard let imageUrl = URL(string: response.message) else { return }
                DogApi.requestImage(url: imageUrl, completionHandler: self.completionHandler(image:error:))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func completionHandler(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

