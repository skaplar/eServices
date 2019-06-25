//
//  Service.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit
import Foundation

class Service: Equatable, Codable {
    
    // MARK: Properties
    var _id: String = ""
    var title: String = ""
    var photo: UIImage?
    var rating: Int = 0
    var city: City?
    var img: String = ""
    var _city: String = ""
    var __v: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case title
        case img
        case _city
        case __v = "__v"
    }
    
    // MARK: Initialization
    
    init?(title: String, photo: UIImage?, rating: Int, city: City, id: String, __v: Int? = 0 ) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties.
        self._id = id
        self.title = title
        self.photo = photo
        self.rating = rating
        self.city = city
    }
    
    init?(_title: String, img: String, _city: String, id: String, __v: Int = 0) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if title.isEmpty  {
            return nil
        }
        
        // Initialize stored properties.
        self._id = id
        self.title = _title
        self.img = img
        self._city = _city
        
    }
    
    public static func == (lhs: Service, rhs: Service) -> Bool {
        return
            lhs.title == rhs.title
    }
}
