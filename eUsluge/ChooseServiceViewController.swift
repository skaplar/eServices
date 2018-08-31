//
//  ChooseServiceViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/30/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import SearchTextField

class ChooseServiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
   
    @IBOutlet weak var chooseServicePickerView: UIPickerView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    let services = ["Cleaning", "Washing", "Dashing"]
    static let cities = [City(name: "Novi Sad", shortName: "NS", code: "21000"), City(name: "Beograd", shortName: "BG", code: "11000")]
    
   
    var filterableCities = [SearchTextFieldItem]()
    var city: City?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        //searchTextField.filterStrings(["Novi Sad", "Beograd"])
        loadCities()
    }
    
    // Here the cities are loaded, currently hardcoded
    // And added to the filterable collection
    func loadCities() {
        for city in ChooseServiceViewController.cities {
            let item = SearchTextFieldItem(title: (city?.name)!, subtitle: city?.shortName)
            filterableCities.append(item)
        }
        
        searchTextField.filterItems(filterableCities)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return services.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // kad se selektuje red da odstampam nesto ili podesim ukoliko mi treba
        print(services[row])
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let serviceTableViewController = segue.destination as? UINavigationController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        let target = serviceTableViewController.topViewController as? ServiceTableViewController
        
        target?.choosenCity = city
    }
 
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    // Set the city to pass to another controller
    // TODO: Force the system to return
    func textFieldDidEndEditing(_ textField: UITextField) {
        for tmpCity in ChooseServiceViewController.cities {
            if tmpCity?.name == searchTextField.text {
                self.city = tmpCity
            }
        }
    }
    
    
    
    // MARK: Actions
    @IBAction func enter(_ sender: UIButton) {
        if searchTextField.text != "" {
            performSegue(withIdentifier: "showServicesTableSegue", sender: self)
        }
    }
}
