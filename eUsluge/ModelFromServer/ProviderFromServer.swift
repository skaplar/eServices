//
//  ProviderFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 6/24/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation

public class ProviderFromServer: Codable {
    
    var name: String = ""
    var _city: City
    var _id: String = ""
    var __v: Int = 0
    
    init?(name: String, _city: City, _id: String, __v: Int? = 0) {
        self.name = name
        self._city = _city
        self._id = _id
    }
    
}
