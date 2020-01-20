//
//  HiredServiceTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/14/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class HiredServiceTableViewController: UITableViewController {

    // MARK: Properties
//    var hiredServices = [HiredService]()
    var hiredServices = [ArrangedServiceFromServer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        hiredServices = DemoData.hiredServices
        print(hiredServices.count)
        
    }
    
    func loadArrServices() {
        let nnc = NewNetworkingClient()
        self.hiredServices.removeAll()
        nnc.genericFetch(urlString: (Utils.ARRANGEDSERVICE + "/123")) { (arrangedServices: [ArrangedServiceFromServer]) in
               for arrService in arrangedServices {
                self.hiredServices.append(arrService)
                self.tableView.reloadData()
               }
               
           }
    
       }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hiredServices = DemoData.hiredServices
        // Ovo bih verovatno trebalo drugacije
        // Odnosno da kad se doda novi red u model
        // da se u tabelu doda samo jedan red
        // Medjutim, posto se posle dodavanja reda u model
        // ne vraca na tabelu, nego na pocetnu stranicu
        // nemamo referencu na tableView pa zbog toga ne mozemo da dodamo samo jedan red
        loadArrServices()
//        tableView.reloadData()
        print(hiredServices.count)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hiredServices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HiredServiceTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HiredServiceTableViewCell else {
            fatalError("The dequeued cell is not an instance of HiredServiceTableViewCell")
        }
        
        let hiredService = hiredServices[indexPath.row]
        
        Alamofire.AF.request(Utils.PHOTOS + "/" + (hiredService._serviceprovider._serviceforcity._service.img)).responseData { response in
            var slika: UIImage?
            if let data = response.data {
                slika = UIImage(data: data, scale:1)
                 cell.serviceProviderImageView.image = slika
            }
        }
        
//        cell.serviceProviderImageView.image = hiredService.serviceProvider.service.photo
        
        cell.serviceProviderNameLabel.text = hiredService._serviceprovider._provider.name
        cell.serviceCityLabel.text = hiredService._serviceprovider._provider._city.name
        var msg = ""
        hiredService.accepted ? (msg = "Completed") : (msg = "Uncompleted")
        cell.serviceFinishedLabel.text = msg
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
