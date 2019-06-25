//
//  ServiceFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/18/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class ServiceFromServer : Codable {
    
    // MARK: Properties
    var _id: String = ""
    var title: String = ""
    var img: String = ""
    var _city: String = ""
    var __v: Int = 0
    
    
    init?(_id: String, title: String, img: String, _city: String, __v: Int? = 0 ) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self._id = _id
        self.title = title
        self.img = img
        self._city = _city
    }
    
}
