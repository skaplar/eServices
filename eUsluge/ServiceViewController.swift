//
//  ServiceViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/15/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var priceLabelView: UILabel!
    @IBOutlet weak var providerLabelView: UILabel!
    @IBOutlet weak var serviceLabelView: UILabel!
    @IBOutlet weak var cityLabelView: UILabel!
    
    /*
     This value is either passed by `ServiceTableViewController` in `prepare(for:sender:)`
     
     */
    var serviceProvider: ServiceProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let serviceProvider = serviceProvider {
            providerLabelView.text = serviceProvider.provider.name
            photoImageView.image = serviceProvider.provider.photo
            ratingControl.rating = Int(round(serviceProvider.rating))
            priceLabelView.text = String(describing: serviceProvider.price)
            serviceLabelView.text = serviceProvider.service.title
            cityLabelView.text = serviceProvider.service.city.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Actions
    // Ovo ako bude trebalo da se odabere slika
    
    
    @IBAction func hireAction(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "Please confirm your selection", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in
            self.finishService() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "HireServiceSegue":
            guard let hireServiceViewController = segue.destination as? HireViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            hireServiceViewController.serviceProvider = serviceProvider
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }
    
    func finishService() {
        let tmp = HiredService(serviceProvider: serviceProvider!, user: "pera")
        DemoData.addHiredService(hs: tmp!)
    }
    
}

