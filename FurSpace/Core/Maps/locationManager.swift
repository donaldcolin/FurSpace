//
//  locationManager.swift
//  FurSpace
//
//  Created by Donald Colin on 15/09/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    
    override init() {
    
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // Request location access
        locationManager.startUpdatingLocation()
    }
    
}
