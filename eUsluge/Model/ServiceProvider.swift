//
//  ServiceProvider.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 9/5/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import UIKit

public class ServiceProvider {
    
    var service: Service
    var provider: Provider
    var rating: Float = 0.0
    var price: Float = 0.0
    var description: String?
    
    init?(service: Service, provider: Provider) {
        self.service = service
        self.provider = provider
    }
}
