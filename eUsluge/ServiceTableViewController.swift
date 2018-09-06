//
//  ServiceTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import os.log

class ServiceTableViewController: UITableViewController {
    // MARK Properties
    
    var services = [Service]()
    var serviceProviders = [ServiceProvider]()
    var choosenCity: City?
    var choosenService: Service?
    
    
    // MARK : Private methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let possibleServiceProviders = DemoData.serviceProviders
        
        for tmpPossibleServiceProvider in possibleServiceProviders {
            if tmpPossibleServiceProvider.service.city == choosenCity && tmpPossibleServiceProvider.service == choosenService {
                serviceProviders.append(tmpPossibleServiceProvider)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return serviceProviders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ServiceTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ServiceTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ServiceTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let serviceProvider = serviceProviders[indexPath.row]
        
        cell.serviceNameLabel.text = serviceProvider.service.title
        cell.photoImageView.image = serviceProvider.service.photo
        cell.ratingControl.rating = serviceProvider.service.rating
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowServiceDetail":
            guard let serviceDetailViewController = segue.destination as? ServiceViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedServiceCell = sender as? ServiceTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedServiceCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedService = serviceProviders[indexPath.row]
            serviceDetailViewController.serviceProvider = selectedService
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
