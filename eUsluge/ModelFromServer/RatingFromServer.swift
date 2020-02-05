//
//  RatingFromServer.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/30/20.
//  Copyright © 2020 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class RatingFromServer : Codable {
    
    var _id: String
    var __v: Int
    var rating: Int
    var comment: String
    var _client: String
    var _provider: String
    var _service: String
    var createdAt: String
    
}
