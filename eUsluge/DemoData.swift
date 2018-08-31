//
//  DemoData.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 8/31/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import Foundation
import UIKit

public class DemoData {
    
    static let cities = [City(name: "Novi Sad", shortName: "NS", code: "21000"), City(name: "Beograd", shortName: "BG", code: "11000")]
    
    
    static func loadSampleServices() -> [Service] {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let service1 = Service(title: "Cleaning the carpets", photo: photo1, rating: 4, city: DemoData.cities[0]!) else {
            fatalError("Unable to instantiate service1")
        }
        
        guard let service2 = Service(title: "Cleaning the carpets", photo: photo2, rating: 3, city: DemoData.cities[1]!) else {
            fatalError("Unable to instantiate service2")
        }
        
        guard let service3 = Service(title: "Picking up the food", photo: photo3, rating: 2, city: DemoData.cities[0]!) else {
            fatalError("Unable to instantiate service3")
        }
        
        var possibleServices = [Service]()
        possibleServices += [service1, service2, service3]
        return possibleServices
    }
}
