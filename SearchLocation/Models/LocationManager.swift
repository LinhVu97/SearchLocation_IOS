//
//  LocationManager.swift
//  SearchLocation
//
//  Created by Vũ Linh on 11/05/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
        
    func findLocation(with query: String, completion: @escaping ([Location]) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models: [Location] = places.compactMap({ place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                
                if let locality = place.locality {
                    name += ", \(locality)"
                }
                
                if let country = place.country {
                    name += ", \(country)"
                }
                
                let result = Location(title: name, coordinates: place.location?.coordinate)
                return result
            })
            completion(models)
        }
    }
}
