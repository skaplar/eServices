//
//  RatingsTableViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/16/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class RatingsTableViewController: UITableViewController {

    // MARK: Properties
    
    var serviceProvider : ServiceProvider?
    var ratings = [RatingFromServer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadRatings()
    }
    
    // MARK: - Communication with server
    
    func loadRatings() {
        let nnc = NewNetworkingClient()
        nnc.genericFetch(urlString: Utils.RATINGS + "/" + (serviceProvider?.provider.id ?? "")) { (ratings: [RatingFromServer]) in
            for rating in ratings {
                print(rating)
                self.ratings.append(rating)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RatingsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RatingsTableViewCell else {
            fatalError("The dequeued cell is not an instance of HiredServiceTableViewCell")
        }
        
        let rating = ratings[indexPath.row]

        cell.userLeftTheCommentLabel.text = rating._client
        cell.ratingUserLeftLabel.text = String(describing: rating.rating!)
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        cell.dateCommentLeftLabel.text = dateFormatter.string(from: rating.dateRated ?? Date())
        cell.commentTextView.text = rating.comment
        cell.serviceProvidedLabel.text = serviceProvider?.service.title
        
//        let dateFormatter = ISO8601DateFormatter()
//        let date = dateFormatter.date(from:rating.createdAt)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from:rating.createdAt!)
        
//        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        // again convert your date to string
        let myDate = formatter.string(from: date!)
        cell.dateCommentLeftLabel.text = myDate
        
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "LeaveRatingSegue":
                //os_log("Adding a new meal.", log: OSLog.default, type: .debug)
                guard let leaveRatingViewController = segue.destination as? LeaveRatingViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                leaveRatingViewController.serviceProvider = serviceProvider
            
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

}
