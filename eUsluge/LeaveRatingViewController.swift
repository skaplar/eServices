//
//  LeaveRatingViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/9/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class LeaveRatingViewController: UIViewController {

    // MARK: Properties
    var serviceProvider : ServiceProvider?
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var serviceRatingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "unwindToChooseService":
                print("Pozove se unwind iako nema funkciju")
                //TODO:  Ovde dodaj provere da li je unesen komentar i da li je ostavljena ocena.
                
                print(commentTextView.text.description)
                print(serviceRatingControl.rating)
                let rating = Rating()
                rating.comment = commentTextView.text.description
                rating.rating = Float(serviceRatingControl.rating)
                // TODO: Pozvati REST Servis eventually
                serviceProvider?.provider.ratings.append(rating)
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }
 

}
