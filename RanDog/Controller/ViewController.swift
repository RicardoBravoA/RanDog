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
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        getBreedList()
    }
    
    private func completionHandler(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private func getBreedList() {
        DogApi.requestBreedsList { data, error in
            self.breeds = data
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
                guard let firstValue = self.breeds.first else { return }
                self.loadRandomImage(value: firstValue)
            }
        }
    }
    
    private func loadRandomImage(value: String) {
        DogApi.requestRandomImage(breed: value) { response, error in
            guard let response = response else{ return }
            guard let imageUrl = URL(string: response.message) else { return }
            DogApi.requestImage(url: imageUrl, completionHandler: self.completionHandler(image:error:))
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
        loadRandomImage(value: breeds[row])
    }
    
}
