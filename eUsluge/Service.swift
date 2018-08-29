//
//  Service.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class Service {
    
    // MARK: Properties
    
    var title: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(title: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.photo = photo
        self.rating = rating
        
    }
}
