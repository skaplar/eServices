//
//  ClientFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 4/8/20.
//  Copyright © 2020 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class ClientFromServer: Codable, Identifiable {
    
    var id: String
    var username: String
    var password: String
    var name: String
    var lastname: String
    var email: String

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case password
        case name
        case lastname
        case email
    }
}
