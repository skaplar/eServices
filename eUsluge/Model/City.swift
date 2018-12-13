//
//  City.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 8/31/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class City: Equatable {
    
    // MARK: Properties
    
    var name: String = ""
    var shortName: String = ""
    var code: String = ""
    
    // MARK: Initialization
    init?(name: String, shortName: String, code: String) {
        
        if name.isEmpty || shortName.isEmpty || code.isEmpty {
            return nil
        }
        
        self.name = name
        self.shortName = shortName
        self.code = code
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return
                lhs.name == rhs.name &&
                lhs.shortName == rhs.shortName &&
                lhs.code == rhs.code
    }
}
