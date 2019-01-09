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
    var photo: UIImage?
    var ratings: [Rating]
    
    init?(name: String, city: City, photo: UIImage?) {
        self.name = name
        self.city = city
        self.photo = photo
        self.services = [Service]()
        self.ratings = [Rating]()
    }
    
}
