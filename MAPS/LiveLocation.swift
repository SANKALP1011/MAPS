//
//  LiveLocation.swift
//  MAPS
//
//  Created by Sankalp Pandey on 04/09/21.
//

import Foundation
import CoreLocation
import MapKit
class locationDelegate: NSObject , ObservableObject , CLLocationManagerDelegate{
    @Published var pins : [Pin] = []
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("authorized")
            manager.startUpdatingLocation()
        }
        else{
            print("not authorized")
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        pins.append(Pin(location: locations.last!))
    }
}

struct Pin: Identifiable{
    var id = UUID().uuidString
    var location: CLLocation
}
