//
//  ServiceViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/15/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import DateTimePicker
import Alamofire


class ServiceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DateTimePickerDelegate {


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

        if let serviceProvider = serviceProvider {
            providerLabelView.text = serviceProvider.provider.name
            photoImageView.image = serviceProvider.provider.photo
            ratingControl.rating = Int(round(serviceProvider.rating))
            priceLabelView.text = String(describing: serviceProvider.price)
            serviceLabelView.text = serviceProvider.service.title
            cityLabelView.text = serviceProvider.service.city?.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Actions
    // Ovo ako bude trebalo da se odabere slika
    
    @IBAction func hireAction(_ sender: Any) {
       /* let alert = UIAlertController(title: "Are you sure?", message: "Please confirm your selection", preferredStyle: UIAlertController.Style.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in
            self.finishService() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)*/
        
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        // customize your picker
        //        picker.timeInterval = DateTimePicker.MinuteInterval.thirty
        //        picker.locale = Locale(identifier: "en_GB")
        //
        //        picker.todayButtonTitle = "Today"
        //        picker.is12HourFormat = true
        //        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        //        picker.isTimePickerOnly = true
        picker.includeMonth = true // if true the month shows at bottom of date cell
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Reserve"
        picker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.timeInterval = DateTimePicker.MinuteInterval.thirty
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.title = formatter.string(from: date)
            
            // FINISH THIS
            let newH: [String: Any] =
                ["_serviceprovider" : self.serviceProvider!.id,
                 "slot" : formatter.string(from: date) ]
            
            Alamofire.AF.request(Utils.ARRANGEDSERVICE, method: .post, parameters: newH,
                              encoding: JSONEncoding.default)
                .responseJSON { response in
                    guard response.error == nil else {
                        // got an error in getting the data, need to handle it
                        print("error")
                        print(response.error!)
                        return
                    }
                    
                    // unwrap JSON
                    guard let json = response.value as? [String: Any] else {
                        print("No JSON")
                        // Could not get JSON
                        return
                    }
                    
                    print(json)
                    // use json
//                    guard let postTitle = json["title"] as? String else {
//                        // Could not get title from json
//                        return
//                    }
//                    print("Post title: " + postTitle)
            }
            
            
        }
        picker.delegate = self
        
        
        // add picker to your view
        // don't try to make customize width and height of the picker,
        // you'll end up with corrupted looking UI
        //        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        // set a dismissHandler if necessary
        //        picker.dismissHandler = {
        //            picker.removeFromSuperview()
        //        }
        //        self.view.addSubview(picker)
        
        // or show it like a modal
        picker.show()
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
            case "showRatingsSegue":
                guard let showRatingsTableViewController = segue.destination as? RatingsTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                showRatingsTableViewController.serviceProvider = serviceProvider
            case "unwindToChooseService":
                print("Pozove se unwind iako nema funkciju")
            case "showDatePickerSegue":
                print("Show date picker")
    //            guard let showRatingsTableViewController = segue.destination as? HireViewController else {
    //                fatalError("Unexpected destination: \(segue.destination)")
    //            }
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }
    
    func finishService() {
        let tmp = HiredService(serviceProvider: serviceProvider!, user: "pera", date: Date())
        DemoData.addHiredService(hs: tmp!)
        print("Dodjem do finisha")
        performSegue(withIdentifier: "unwindToChooseService", sender: self)
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        title = picker.selectedDateString
    }
    
}

