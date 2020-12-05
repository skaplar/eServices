//
//  ServiceTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import os.log
import Alamofire

class ServiceTableViewController: UITableViewController {
    
    // MARK Properties
    var services = [Service]()
    var serviceProviders = [ServiceProvider]()
    
    // Ovo se setuje iz ChooseServiceViewController
    var choosenCity: City?
    var choosenService: Service?
    
    // MARK : Private methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = choosenService?.title
//        tableView.rowHeight = UITableView.
//        tableView.estimatedRowHeight = 60
        
//        let possibleServiceProviders = DemoData.serviceProviders
//        for tmpPossibleServiceProvider in possibleServiceProviders {
//            if tmpPossibleServiceProvider.service.city == choosenCity && tmpPossibleServiceProvider.service == choosenService {
//                serviceProviders.append(tmpPossibleServiceProvider)
//            }
//        }
        
        let nnc = NewNetworkingClient()
        let sers = Utils.SERVICEFORCITY + "/" + choosenCity!._id + "/" + choosenService!._id
        print(sers)
        nnc.genericFetch(urlString: sers) { (serviceproviders2: [ServiceProviderFromServer]) in
            for tmpProv in serviceproviders2 {
                let imgToFetch = tmpProv.img != nil ? tmpProv.img : tmpProv._serviceforcity._service.img
                
                Alamofire.AF.request(Utils.PHOTOS + "/" + (imgToFetch!)).responseData { response in
                    var slika: UIImage?
                    if let data = response.data {
                        slika = UIImage(data: data, scale:1)
                        
                    }
                    
                    let s2 = Service(
                        title: (tmpProv._serviceforcity._service.title),
                        photo: slika,
                        rating: Int(tmpProv.rating),
                        city: tmpProv._serviceforcity._city!,
                        id: tmpProv._serviceforcity._service._id
                    )
                    
                    let provider = Provider(name: tmpProv._provider.name, city: tmpProv._provider._city, photo: slika)
                    provider?.id = tmpProv._provider._id
                    
                    let sp = ServiceProvider(service: s2!, provider: provider!)
                    sp?.rating = tmpProv.rating
                    sp?.price = tmpProv.price
                    sp?.description = tmpProv.description
                    sp?.id = tmpProv._id
                    
                    self.serviceProviders.append(sp!)
                    self.tableView.reloadData()
                }
                // Ovde sad treba pretabati u odgovarajuci service provider
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
        
        cell.serviceNameLabel.text = serviceProvider.provider.name
        cell.photoImageView.image = serviceProvider.provider.photo
        cell.ratingControl.rating = Int(round(serviceProvider.rating))
        cell.priceLabel.text = String(serviceProvider.price)
        
        

//        cell.photoImageView.layer.borderWidth = 1
        cell.photoImageView.layer.masksToBounds = true
//        cell.photoImageView.draw(CGRect(x: 0, y: 0, width: 100, height: 100))
//        cell.photoImageView.layer.borderColor = UIColor.black.cgColor
//        cell.photoImageView.layer.cornerRadius = cell.photoImageView.frame.height / 2
        cell.photoImageView.layer.cornerRadius = 5
//        cell.photoImageView.layer.cornerRadius = (cell.photoImageView?.frame.size.width ?? 0.0) / 2
        cell.photoImageView.clipsToBounds = true
        
        
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
