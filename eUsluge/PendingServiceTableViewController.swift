//
//  HiredServiceTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/14/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class PendingServiceTableViewController: UITableViewController {
    
    

    // MARK: Properties
//    var hiredServices = [HiredService]()
    var hiredServices = [ArrangedServiceFromServer]()
    var rescheduledServices = [RescheduledServiceFromServer]()
    var mapping: [String: [RescheduledServiceFromServer]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        hiredServices = DemoData.hiredServices
    }
    
    func loadArrServices() {
        let nnc = NewNetworkingClient()
        self.hiredServices.removeAll()
        nnc.genericFetch(urlString: (Utils.ARRANGEDSERVICE + "/" + Utils.CLIENT_ID)) { (arrangedServices: [ArrangedServiceFromServer]) in
                for arrService in arrangedServices {
                    if arrService.status == .pending {
                        self.hiredServices.append(arrService)
//                        self.tableView.reloadData()
                    }
                }
            self.loadRescheduledMessages()
        }
    }
    
    func loadRescheduledMessages() {
        let nnc = NewNetworkingClient()
//        self.rescheduledServices.removeAll()
        self.mapping.removeAll()
        for hiredService in hiredServices {
            self.mapping[hiredService._id] = [RescheduledServiceFromServer]()
            print(Utils.RESCHEDULEDSERVICE_FORARRANGED + "/" + hiredService._id)
            nnc.genericFetch(urlString: (Utils.RESCHEDULEDSERVICE_FORARRANGED + "/" + hiredService._id)) { (rescheduledServices: [RescheduledServiceFromServer]) in
                    for rescheduledService in rescheduledServices {
                        self.mapping[hiredService._id]?.append(rescheduledService)
                    }
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
                
        cell.serviceProviderNameLabel.text = hiredService._serviceprovider._provider.name
        cell.serviceCityLabel.text = hiredService._serviceprovider._provider._city.name
        cell.serviceFinishedLabel.text = hiredService.status.rawValue
        print(hiredService.slot)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let datez = formatter.date(from:hiredService.slot)!

        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        // again convert your date to string
        let myDate = formatter.string(from: datez)

        cell.serviceDateLabel.text = myDate.description
        cell.serviceNameLabel.text = hiredService._serviceprovider._serviceforcity._service.title
        
        if hiredService.status == .pending && self.mapping[hiredService._id]?.count ?? 0 > 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hiredService = hiredServices[indexPath.row]
         if hiredService.status == .pending && self.mapping[hiredService._id]?.count ?? 0 > 0 {
            self.performSegue(withIdentifier: "RescheduledServicesSegue", sender: self.mapping[hiredService._id])
        }
        
        // deselektuj celiju
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // da li ovo radi nadam se da da
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // sender is hiredService, passed from tableView didSelectRowAt
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "RescheduledServicesSegue":
                guard let leaveRatingViewController = segue.destination as? RescheduledServicesTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }

                leaveRatingViewController.rescheduledServices = (sender as? [RescheduledServiceFromServer])!
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

}
