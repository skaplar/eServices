//
//  NewNetworkingClient.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/15/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import Alamofire

class NewNetworkingClient {
    
    func genericFetch<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        Alamofire.AF.request(urlString, method: .get).validate(statusCode: 200..<300).response { response in
        
            guard response.error == nil else {
                print("error calliing on \(urlString)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
            
        }
    }
}
