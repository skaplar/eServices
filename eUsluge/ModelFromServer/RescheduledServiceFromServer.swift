//
//  RescheduledServiceFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 4/3/20.
//  Copyright © 2020 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class RescheduledServiceFromServer: Codable, Identifiable {
    
    var id: String
    var accepted: Bool
    var client: ClientFromServer
    var message: String
    var provider: String
    var date: String
    var arrangedservice: String
    var sender: ClientFromServer
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case client = "_client"
        case date
        case message
        case accepted
        case provider = "_provider"
        case arrangedservice = "_arrangedservice"
        case sender = "_sender"
    }
}
