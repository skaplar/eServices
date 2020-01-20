//
//  Utils.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 1/15/19.
//  Copyright © 2019 Sebastijan Kaplar. All rights reserved.
//

import Foundation

class Utils {
    
    public static let API = "http://localhost:3000/"
    public static let CITIES =  API + "cities"
    public static let SERVICES = API + "services"
    public static let PHOTOS = API + "images"
    public static let SERVICEPROVIDERS = API + "serviceproviders"
    public static let SERVICEFORCITY = API + "serviceforcity"
    public static let ARRANGEDSERVICE = API + "arrangedservices"
    
    func stariPrimeri() {
 /*
        // Ovo radi, imam tip odgovora response
        // izvlacim njegov data i onda ga dekodujem
        // dosta ima rucno posla
         // tip response.data je Optional<Data>
        Alamofire.AF.request("http://localhost:3000/cities").response {
            response in
     
     
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
     
            do {
                let model = try JSONDecoder().decode([City].self, from: data)
                print(model)
                for m in model {
                    print(m)
                }
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
     
     
        }
 */
        /*

        Alamofire.AF.request("http://localhost:3000/cities").responseJSON {
            response in
            //print(response)
     
     
            if let cityJSON = response.result.value as? [Any] {
                for object in cityJSON {
                    print(object)
     
                   print(type(of: object))
                    let city = object as! [String: Any]
                    let id = city["_id"] as? String
                    let name = city["name"] as? String
                    print(id!)
                    print(name!)
                }
 
        }
         }*/
        /*
        guard let urll = URL(string: "http://localhost:3000/cities") else { return }
        let nc = NetworkingClient()
     
        nc.execute(urll) {
            (json, error) in
            if let error = error {
                print(error)
            } else if let json = json {
                print(json)

                for city in json {
                    let id = city["_id"] as? String
                    let name = city["name"] as? String
                    print(id!)
                    print(name!)
                }
            }
        }*/
}
    func getCities(url: String) ->  [City] {
        let nnc = NewNetworkingClient()
        var cit = [City]()
        nnc.genericFetch(urlString: url) { (cities: [City]) in
            print(cities)
            for city in cities {
                cit.append(city)
            }
           
        }
        return cit
    }
    
    func getServices(url: String) -> [ServiceFromServer] {
        let nnc = NewNetworkingClient()
        var services = [ServiceFromServer]()
        nnc.genericFetch(urlString: url) { (tmpServices: [ServiceFromServer]) in
            print(tmpServices)
            
            
        }
        
        return services
    }
    
    
}
