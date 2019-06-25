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
    static var hiredServices = DemoData.loadSampleHiredServices()
    
    static func loadSampleServices() -> [Service] {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let service1 = Service(title: "Cleaning the carpets", photo: photo1, rating: 4, city: DemoData.cities[0]!, id: "1") else {
            fatalError("Unable to instantiate service1")
        }
        
        guard let service2 = Service(title: "Cleaning the floors", photo: photo2, rating: 3, city: DemoData.cities[0]!, id: "2") else {
            fatalError("Unable to instantiate service2")
        }
        
        guard let service3 = Service(title: "Picking up the food", photo: photo3, rating: 2, city: DemoData.cities[0]!, id: "3") else {
            fatalError("Unable to instantiate service3")
        }
        
        guard let service4 = Service(title: "Oil Massage", photo: photo3, rating: 2, city: DemoData.cities[1]!, id: "4") else {
            fatalError("Unable to instantiate service4")
        }
        
        var possibleServices = [Service]()
        possibleServices += [service1, service2, service3, service4]
        return possibleServices
    }
    
    static func loadProviders() -> [Provider] {
        var possibleProviders = [Provider]()
        
        let photo1 = UIImage(named: "logo3")
        guard let serviceProvider1 = Provider(name: "Karpenterija DOO NS", city: cities[0]!, photo: photo1) else {
            fatalError("Unable to instantiate serviceProvider1")
        }
        
        var rating1 = Rating()
        rating1.comment = "Odlicna usluga od proizvodjaca usluga"
        rating1.rating = 5
        rating1.dateRated = Date()
        
        var rating2 = Rating()
        
        rating2.comment = "Vrlo dobra usluga"
        rating2.rating = 4
        rating2.dateRated = Date()
        serviceProvider1.ratings.append(rating1)
        serviceProvider1.ratings.append(rating2)
        
        let photo2 = UIImage(named: "logo2")
        guard let serviceProvider2 = Provider(name: "Fast Food BG", city: cities[1]!, photo: photo2) else {
            fatalError("Unable to instantiate serviceProvider2")
        }
        
        var rating3 = Rating()
        rating3.comment = "Dobra... usluga od proizvodjaca usluga"
        rating3.rating = 3
        rating3.dateRated = Date()
        
        var rating4 = Rating()
        
        rating4.comment = "dobra usluga"
        rating4.rating = 3
        rating4.dateRated = Date()
        serviceProvider2.ratings.append(rating3)
        serviceProvider2.ratings.append(rating4)
        
        let photo3 = UIImage(named: "logo1")
        guard let serviceProvider3 = Provider(name: "Masazer NS", city: cities[0]!, photo: photo3) else {
            fatalError("Unable to instantiate serviceProvider3")
        }
        
        var rating5 = Rating()
        rating5.comment = "Dobra... do jedva "
        rating5.rating = 2
        rating5.dateRated = Date()
        
        var rating6 = Rating()
        
        rating6.comment = "dobra usluga"
        rating6.rating = 3
        rating6.dateRated = Date()
        serviceProvider3.ratings.append(rating5)
        serviceProvider3.ratings.append(rating6)
        
        possibleProviders += [serviceProvider1, serviceProvider2, serviceProvider3]
        return possibleProviders
    }
    
    static func loadServiceProviders() -> [ServiceProvider] {
        var possibleServiceProviders = [ServiceProvider]()
        
        guard let serviceProvider1 = ServiceProvider(service: DemoData.services[0], provider: DemoData.providers[0]) else {
            fatalError("Unable to instantiate sp1")
        }
        
        serviceProvider1.rating = 3
        serviceProvider1.price = 230
        
        guard let serviceProvider2 = ServiceProvider(service: DemoData.services[1], provider: DemoData.providers[0]) else {
            fatalError("Unable to instantiate sp2")
        }
        
        serviceProvider2.rating = 4
        serviceProvider2.price = 400
        
        guard let serviceProvider3 = ServiceProvider(service: DemoData.services[2], provider: DemoData.providers[1]) else {
            fatalError("Unable to instantiate sp3")
        }
        
        serviceProvider3.rating = 2
        serviceProvider3.price = 500
        
        guard let serviceProvider4 = ServiceProvider(service: DemoData.services[3], provider: DemoData.providers[2]) else {
            fatalError("Unable to instantiate sp4")
        }
        
        serviceProvider4.rating = 5
        serviceProvider4.price = 600
        
        guard let serviceProvider5 = ServiceProvider(service: DemoData.services[2], provider: DemoData.providers[2]) else {
            fatalError("Unable to instantiate sp5")
        }
        
        serviceProvider5.rating = 4
        serviceProvider5.price = 700
        
        possibleServiceProviders += [serviceProvider1, serviceProvider2, serviceProvider3, serviceProvider4, serviceProvider5]
        return possibleServiceProviders
    }
    
    static func addHiredService(hs: HiredService) {
        hiredServices.append(hs)
    }
    
    static func loadSampleHiredServices() -> [HiredService] {
        var hiredServices = [HiredService]()
       
        guard let hiredService1 = HiredService(serviceProvider: DemoData.serviceProviders[0], user: "pera", date: Date()) else {
            fatalError("Unable to instantiate hs1")
        }
        
        guard let hiredService2 = HiredService(serviceProvider: DemoData.serviceProviders[2], user: "pera", date: Date()) else {
            fatalError("Unable to instantiate hs2")
        }
        
        hiredServices += [hiredService1, hiredService2]
        return hiredServices
    }
}
