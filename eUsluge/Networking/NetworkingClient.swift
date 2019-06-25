//
//  NetworkingClient.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/15/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    

    typealias WebServiceResponse = ([[String:Any]]?, Error?) -> Void
    
    func execute(_ url: URL, completion: @escaping WebServiceResponse) {
        Alamofire.AF.request("http://localhost:3000/cities").validate().responseJSON { response in
            
            // OVO SE VISE NE KORISTI NITI RADI
                // BILO JE RANIJE response.result.value
            
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.data as? [[String:Any]] {
                
                completion(jsonArray, nil)
            } else if let jsonDictionary = response.data as? [String:Any] {
                completion([jsonDictionary], nil)
            }
        }
    }
    
}
