//
//  City.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 8/31/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class City: Equatable, Codable {
    
    // MARK: Properties
    var _id: String = ""
    var name: String = ""
    var shortname: String = ""
    var code: String = ""
    var __v:Int = 0
    
    // MARK: Initialization
    init?(name: String, shortName: String, code: String, __v: Int? = 0) {
        
        if name.isEmpty || shortName.isEmpty || code.isEmpty {
            return nil
        }
        
        self.name = name
        self.shortname = shortName
        self.code = code
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return
                lhs.name == rhs.name &&
                lhs.shortname == rhs.shortname &&
                lhs.code == rhs.code
    }
}
