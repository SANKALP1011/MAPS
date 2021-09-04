//
//  ContentView.swift
//  MAPS
//
//  Created by Sankalp Pandey on 01/09/21.
//

import SwiftUI
import CoreLocation
import MapKit
struct ContentView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @State var tracking: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @State var managerDelegate = locationDelegate()
    
    var body: some View {
        NavigationView{
            VStack{
                
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: managerDelegate.pins) { Pin in
                        MapPin(coordinate: Pin.location.coordinate, tint: .blue)
                    }
                    }
            .navigationBarTitle("MAPS")
            .onAppear(){
                manager.delegate = managerDelegate
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

//    class locationDelegate: NSObject , ObservableObject , CLLocationManagerDelegate{
//        @Published var pins : [Pin] = []
//        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
//                print("authorized")
//                manager.startUpdatingLocation()
//            }
//            else{
//                print("not authorized")
//                manager.requestWhenInUseAuthorization()
//            }
//        }
//
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            pins.append(Pin(location: locations.last!))
//        }
//    }
//
//    struct Pin: Identifiable{
//        var id = UUID().uuidString
//        var location: CLLocation
//    }
