//
//  ViewController.swift
//  RanDog
//
//  Created by Ricardo Bravo on 23/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    let breeds: [String] = ["greyhound", "poodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func completionHandler(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestRandomImage { response, error in
            guard let response = response else{ return }
            guard let imageUrl = URL(string: response.message) else { return }
            DogApi.requestImage(url: imageUrl, completionHandler: self.completionHandler(image:error:))
        }
    }
}
