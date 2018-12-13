//
//  HiredService.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/13/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import UIKit

class HiredService {
    
    var serviceProvider: ServiceProvider
    var finished: Bool = false
    var user: String = ""
    
    init?(serviceProvider: ServiceProvider, user: String) {
        self.serviceProvider = serviceProvider
        self.user = user
    }
    
    
    
}
