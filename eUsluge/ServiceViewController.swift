//
//  ServiceViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/15/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    /*
     This value is either passed by `ServiceTableViewController` in `prepare(for:sender:)`
     
     */
    var serviceProvider: ServiceProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let serviceProvider = serviceProvider {
            titleTextField.text = serviceProvider.service.title
            photoImageView.image = serviceProvider.service.photo
            ratingControl.rating = serviceProvider.service.rating
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Actions
    // Ovo ako bude trebalo da se odabere slika
    
}

