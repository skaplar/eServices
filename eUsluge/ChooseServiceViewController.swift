//
//  ChooseServiceViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/30/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import SearchTextField
import Alamofire
import SwiftUI

class ChooseServiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
   
    let swiftUIView = PendingServicesUIView()
    
    @IBOutlet weak var chooseServicePickerView: UIPickerView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    // let services = ["Cleaning", "Washing", "Dashing"]
    //let services = DemoData.services
    var services = [Service]()
    var filterableCities = [SearchTextFieldItem]()
    var city: City?
    var service: Service?
    var cities =  [City]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        //searchTextField.filterStrings(["Novi Sad", "Beograd"])
        loadCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // Here the cities are loaded, currently hardcoded
    // And added to the filterable collection
    func loadCities() {
        let nnc = NewNetworkingClient()
        nnc.genericFetch(urlString: Utils.CITIES) { (cities: [City]) in
            for city in cities {
                let item = SearchTextFieldItem(title: (city.name), subtitle: city.shortname)
                self.filterableCities.append(item)
            }
            self.cities = cities
            self.searchTextField.filterItems(self.filterableCities)
            
            // After loading the cities, in the callback we call the load Services
            // which relies on previous cities
            self.loadServices()
        }
 
        /*
        for city in DemoData.cities {
            let item = SearchTextFieldItem(title: (city?.name)!, subtitle: city?.shortname)
            filterableCities.append(item)
        }
        searchTextField.filterItems(filterableCities)
         */
    }
    
    func loadServices() {
        let nnc = NewNetworkingClient()
        nnc.genericFetch(urlString: Utils.SERVICES) { (tmpServices: [ServiceFromServer]) in
            print(tmpServices)
            for tmpService in tmpServices {
                let city = self.getCity(cityId: tmpService._city)
                Alamofire.AF.request(Utils.PHOTOS + "/" + tmpService.img).responseData { response in
                    var slika: UIImage?
                    if let data = response.data {
                        slika = UIImage(data: data, scale:1)
                    }
                    
                    let service = Service(title: tmpService.title, photo: slika, rating: 0, city: city!, id: tmpService._id)
                    
                    // OK ovo da stoji ovde je los dizajn
                    // Ali stavio sam ga da ne puca aplikacija
                    // puca iz razloga zato sto se prvo ucita view pa tek onda se fetchuju podaci sa servera
                    // razradi kako da resis to
                    self.services.append(service!)
                    self.chooseServicePickerView.reloadAllComponents()
                }
            }
        }
    }
    
    func getCity(cityId: String) -> City? {
        for city in cities {
            if (city._id == cityId) {
                return city
            }
        }
        return nil
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
        return services[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // kad se selektuje red da odstampam nesto ili podesim ukoliko mi treba
        //print(services[row])
        if services.count > 0 {
            service = services[row]
        }
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
        target?.choosenService = service
    }
 
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    // Set the city to pass to another controller
    // TODO: Force the system to return
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Ovako je bilo pre prelaska na server
//        for tmpCity in DemoData.cities {
//            if tmpCity?.name == searchTextField.text {
//                self.city = tmpCity
//            }
//        }
        for tmpCity in cities {
            if tmpCity.name == searchTextField.text {
                self.city = tmpCity
            }
        }
    }
    
    
    
    // MARK: Actions
    @IBAction func enter(_ sender: UIButton) {
        if searchTextField.text != "" {
            searchTextField.resignFirstResponder()
            performSegue(withIdentifier: "showServicesTableSegue", sender: self)
        }
    }
    
    @IBAction func unwindToChooseService(sender: UIStoryboardSegue) {
        // Ovo ovde mi je kad se pritisne dugme HIRE da se vrati na ovaj ekran
        // Iako nista ne radi na njega se vracam
        
    }
}
