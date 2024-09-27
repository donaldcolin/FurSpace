//
//  LocationManager.swift
//  FurSpace
//
//  Created by Donald Colin on 27/09/24.
//


import CoreLocation
import UIKit
import SwiftUI

class LocationManage: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var place: String?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // Request permission to access location
    func requestLocationAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    // Request the current location
    func requestLocation() {
        manager.requestLocation() // This method triggers the delegate method
    }

    // Delegate method: Called when locations are updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lookUpCurrentLocation { placemark in
            self.place = placemark
        }
    }

    // Reverse geocode location to get the place name
    func lookUpCurrentLocation(completionHandler: @escaping (String?) -> Void) {
        // Use the last reported location.
        if let lastLocation = manager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0].name
                    completionHandler(firstLocation)
                } else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        } else {
            // No location was available.
            completionHandler(nil)
        }
    }

    // Delegate method: Called when location updates fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
    }
}
