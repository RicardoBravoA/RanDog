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
        
        DogApi.requestRandomImage { response, error in
            guard let response = response else{ return }
            guard let imageUrl = URL(string: response.message) else { return }
            DogApi.requestImage(url: imageUrl, completionHandler: self.completionHandler(image:error:))
        }
    }
    
    private func completionHandler(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

