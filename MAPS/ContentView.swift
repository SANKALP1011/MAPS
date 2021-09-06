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

    @State var manager = CLLocationManager()
    @State var alert = false
    
    var body: some View {
        NavigationView{
            VStack{
                MapView(manager: $manager, alert: $alert).alert(isPresented: $alert, content: {
                    Alert(title: Text("PLEASE ALLOW US TO ACCESS YOUR LOCATION"))
                })
                   
                    }
            .navigationBarTitle("MAPS")
            .onAppear(){
                
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

struct MapView: UIViewRepresentable{
    
    @Binding var manager: CLLocationManager
    @Binding var alert: Bool
    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        let centre = CLLocationCoordinate2DMake(13.04, 80.2)
        let region = MKCoordinateRegion(center: centre, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.region = region
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        return map
    }
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    class MapCoordinate: NSObject , CLLocationManagerDelegate{
        
        var newParent : MapView
            init(parent: MapView){
            newParent = parent
            }
        
        func locationManager(_ manager: CLLocationManager , didChangeAuthorization status: CLAuthorizationStatus){
        
            if status == .denied{
                newParent.alert.toggle()
            }
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let realLocation = locations.last!
            let mapPin = MKPointAnnotation()
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(realLocation) { [self] (places , error) in
                
                if error != nil{
                    print(error?.localizedDescription)
                }
                let place = places?.first?.locality
                mapPin.title = place
                mapPin.subtitle = "Current Location"
                mapPin.coordinate = realLocation.coordinate
                newParent.map.removeAnnotation(newParent.map.annotations as! MKAnnotation)
                newParent.map.addAnnotation(mapPin)
                
                let region = MKCoordinateRegion(center: realLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                newParent.map.region = region
                
            }
            
        }
    }
    
}
    

