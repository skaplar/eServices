//
//  ServiceProvider.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 9/5/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import UIKit

public class Provider {
    
    var name: String
    var city: City
    var services: [Service]
    
    init?(name: String, city: City) {
        self.name = name
        self.city = city
        self.services = [Service]()
    }
    
}
