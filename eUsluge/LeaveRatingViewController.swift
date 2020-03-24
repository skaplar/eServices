//
//  LeaveRatingViewController.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/9/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Alamofire

class LeaveRatingViewController: UIViewController {

    // MARK: Properties
    var serviceProvider : ServiceProvider?
    var arrangedService : ArrangedServiceFromServer?
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var serviceRatingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commentTextView!.layer.borderWidth = 1
        commentTextView!.layer.borderColor = UIColor.red.cgColor
        
        print(arrangedService?._id)
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
                let rating = RatingFromServer()
                rating.comment = commentTextView.text.description
                rating.rating = Int(serviceRatingControl.rating)
                rating._client = arrangedService?._client
                rating._provider = arrangedService?._serviceprovider._provider._id
                rating._service = arrangedService?._serviceprovider._serviceforcity._service._id
                
//                let jsonData = try! JSONEncoder().encode(rating)
//                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                let dict: [String: Any] =
                ["comment" : commentTextView.text.description,
                 "rating" : serviceRatingControl.rating,
                 "_client" : arrangedService?._client!,
                 "_provider" : arrangedService?._serviceprovider._provider._id,
                "_service" : arrangedService?._serviceprovider._serviceforcity._service._id ]
            
                Alamofire.AF.request(Utils.RATINGS + "/" + arrangedService!._id, method: .post, parameters: dict,
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
                
                
                
                // TODO: Pozvati REST Servis eventually
//                serviceProvider?.provider.ratings.append(rating)
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }   
    }
}
