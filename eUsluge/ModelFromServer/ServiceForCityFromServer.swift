//
//  ServiceForCityFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 6/24/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class ServiceForCityFromServer : Codable {
    
    // MARK: Properties
    var _id: String = ""
    var _city: City?
    var _service: ServiceFromServer
    var __v: Int = 0
    
    
    init?(_id: String, _city: City, _service: ServiceFromServer, __v: Int = 0 ) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if _id.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self._id = _id
        self._city = _city
        self._service = _service
    }
    
}
