//
//  ArrangedServiceFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/19/20.
//  Copyright © 2020 Sebastijan Kaplar. All rights reserved.
//

import Foundation


class ArrangedServiceFromServer : Codable {
    
    enum Status: String, Codable {
           case pending
           case accepted
           case completed
    }

    // MARK: Properties
    var _id: String = ""
    var slot: String = ""
    var accepted: Bool = false
    var status: Status = .pending
    var _serviceprovider: ServiceProviderFromServer
    var _client: String?
    var _rating: String? = nil
    var __v: Int = 0
    
    
    init?(_id: String, slot: String, accepted: Bool, _serviceprovider: ServiceProviderFromServer, __v: Int = 0, status: Status, _rating: String, _client: String) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if _id.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self._id = _id
        self.slot = slot
        self.accepted = accepted
        self._serviceprovider = _serviceprovider
        self.status = status
        self._rating = _rating
        self._client = _client
    }
    
}
