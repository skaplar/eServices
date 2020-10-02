//
//  HiredServiceTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/14/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class RescheduledServicesTableViewController: UITableViewController {
    
    

    // MARK: Properties
//    var hiredServices = [HiredService]()
//    var hiredServices = [ArrangedServiceFromServer]()
    var rescheduledServices : [RescheduledServiceFromServer] = []
    let currentUserId = UserDefaults.standard.string(forKey: "_id")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        hiredServices = DemoData.hiredServices
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        tableView.reloadData()
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rescheduledServices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HiredServiceTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HiredServiceTableViewCell else {
            fatalError("The dequeued cell is not an instance of HiredServiceTableViewCell")
        }
        
        let hiredService = rescheduledServices[indexPath.row]
                
        cell.serviceProviderNameLabel.text = hiredService.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let datez = formatter.date(from:hiredService.date)!
        
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        // again convert your date to string
        let myDate = formatter.string(from: datez)
        
        cell.serviceCityLabel.text = ""
//        cell.serviceFinishedLabel.text = "Accepted: " + String(hiredService.accepted)
        cell.serviceFinishedLabel.text = myDate
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        if hiredService.sender.id == currentUserId {
            cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        } else {
            cell.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)
        }
        
        
        
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // Ovo je kad kliknem na celiju, dobijem indeks, proverim uslov ukoliko je ok prelazim na rating
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let hiredService = hiredServices[indexPath.row]
//        if hiredService.status == .completed && hiredService._rating == nil {
//            self.performSegue(withIdentifier: "LeaveRatingSegue", sender: hiredService)
//        }
//        
//        // deselektuj celiju
//        if let index = self.tableView.indexPathForSelectedRow{
//            self.tableView.deselectRow(at: index, animated: true)
//        }
//    }
    
    // da li ovo radi nadam se da da
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        return false
//        
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // sender is hiredService, passed from tableView didSelectRowAt
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "LeaveRatingSegue":
                guard let leaveRatingViewController = segue.destination as? LeaveRatingViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }

                leaveRatingViewController.arrangedService = sender as? ArrangedServiceFromServer
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    func sendData(message: String) {
        if rescheduledServices.count <= 0 {
            return
        }
        let tmpService = rescheduledServices[0]
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let newH: [String: Any] =
            ["_arrangedservice" : tmpService.arrangedservice,
//             "date" : formatter.string(from: self.birthDate),
            "date" : formatter.string(from: Date()),
             "accepted" : false,
             "message" : message,
             "_client" : tmpService.client,
             "_provider" : tmpService.provider,
             "_sender" : Utils.CLIENT_ID]
        
        let putanja = "http://localhost:3000/rescheduledservices"
        
        Alamofire.AF.request(putanja, method: .post, parameters: newH,
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
        }
    }
    
    @IBAction func sendMessage(_ sender: UIBarButtonItem) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Message", message: "Enter the message", preferredStyle: .alert)
       
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Send", style: .default) { (_) in
            //getting the input values from user
            let name = alertController.textFields?[0].text
            self.sendData(message: name!)
       }
       
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
       
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Message details..."
        }
       
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
       
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}
