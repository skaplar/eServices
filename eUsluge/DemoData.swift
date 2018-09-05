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
    
    static let services = DemoData.loadSampleServices()
    static let providers = DemoData.loadProviders()
    static let serviceProviders = DemoData.loadServiceProviders()
    
    static func loadSampleServices() -> [Service] {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let service1 = Service(title: "Cleaning the carpets", photo: photo1, rating: 4, city: DemoData.cities[0]!) else {
            fatalError("Unable to instantiate service1")
        }
        
        guard let service2 = Service(title: "Cleaning the floors", photo: photo2, rating: 3, city: DemoData.cities[0]!) else {
            fatalError("Unable to instantiate service2")
        }
        
        guard let service3 = Service(title: "Picking up the food", photo: photo3, rating: 2, city: DemoData.cities[0]!) else {
            fatalError("Unable to instantiate service3")
        }
        
        guard let service4 = Service(title: "Oil Massage", photo: photo3, rating: 2, city: DemoData.cities[1]!) else {
            fatalError("Unable to instantiate service4")
        }
        
        var possibleServices = [Service]()
        possibleServices += [service1, service2, service3, service4]
        return possibleServices
    }
    
    static func loadProviders() -> [Provider] {
        var possibleProviders = [Provider]()
        
        guard let serviceProvider1 = Provider(name: "Karpenterija DOO NS", city: cities[0]!) else {
            fatalError("Unable to instantiate serviceProvider1")
        }
        
//        serviceProvider1.services.append(DemoData.services[0])
//        serviceProvider1.services.append(DemoData.services[1])
        
        guard let serviceProvider2 = Provider(name: "Fast Food BG", city: cities[1]!) else {
            fatalError("Unable to instantiate serviceProvider2")
        }
        
//        serviceProvider2.services.append(DemoData.services[2])
        
        guard let serviceProvider3 = Provider(name: "Masazer NS", city: cities[0]!) else {
            fatalError("Unable to instantiate serviceProvider3")
        }
        
//        serviceProvider3.services.append(DemoData.services[3])
        
        possibleProviders += [serviceProvider1, serviceProvider2, serviceProvider3]
        return possibleProviders
    }
    
    static func loadServiceProviders() -> [ServiceProvider] {
        var possibleServiceProviders = [ServiceProvider]()
        
        guard let serviceProvider1 = ServiceProvider(service: DemoData.services[0], provider: DemoData.providers[0]) else {
            fatalError("Unable to instantiate sp1")
        }
        
        guard let serviceProvider2 = ServiceProvider(service: DemoData.services[1], provider: DemoData.providers[0]) else {
            fatalError("Unable to instantiate sp2")
        }
        
        guard let serviceProvider3 = ServiceProvider(service: DemoData.services[2], provider: DemoData.providers[1]) else {
            fatalError("Unable to instantiate sp3")
        }
        
        guard let serviceProvider4 = ServiceProvider(service: DemoData.services[3], provider: DemoData.providers[2]) else {
            fatalError("Unable to instantiate sp4")
        }
        
        possibleServiceProviders += [serviceProvider1, serviceProvider2, serviceProvider3, serviceProvider4]
        return possibleServiceProviders
    }
}
