//
//  ServiceProviderFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 6/23/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation


class ServiceProviderFromServer : Codable {
    
    // MARK: Properties
    var _id: String = ""
    var _serviceforcity: ServiceForCityFromServer
    var _provider: ProviderFromServer
    var rating: Float = 0.0
    var price: Float = 0.0
    var description: String?
    var img: String?
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case _serviceforcity
        case _provider
        case rating
        case price
        case description
        case img
    }
    
    init?(_id: String, _serviceforcity: ServiceForCityFromServer, _provider: ProviderFromServer, rating: Float, price: Float, description: String, img: String) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if _id.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self._id = _id
        self._serviceforcity = _serviceforcity
        self._provider = _provider
        self.rating = rating
        self.description = description
        self.price = price
        self.img = img
    }
    
    
    
}
