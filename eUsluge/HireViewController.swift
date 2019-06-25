//
//  HireViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/13/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import DateTimePicker

class HireViewController: UIViewController, DateTimePickerDelegate {
    
    
    // MARK: Properties
    var serviceProvider: ServiceProvider?
    @IBOutlet weak var serviceProviderNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //serviceProviderNameLabel.text = serviceProvider!.provider.name
        // Do any additional setup after loading the view.
        //print(serviceProvider!)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "HireServiceSegue":
            print("Hire segue")
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        title = picker.selectedDateString
    }

}
