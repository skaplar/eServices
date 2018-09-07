//
//  Service.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class Service: Equatable {
    
    // MARK: Properties
    
    var title: String
    var photo: UIImage?
    var rating: Int
    var city: City
    
    // MARK: Initialization
    
    init?(title: String, photo: UIImage?, rating: Int, city: City) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.photo = photo
        self.rating = rating
        self.city = city
    }
    
    public static func == (lhs: Service, rhs: Service) -> Bool {
        return
            lhs.title == rhs.title
    }
}
