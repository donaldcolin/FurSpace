import CoreLocation
import SwiftUI

class LocationManage: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    // Observable object properties
    @Published var place: String? // For displaying a human-readable place
    @Published var coordinate: CLLocationCoordinate2D? // For storing the actual coordinates
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Request location authorization
    func requestLocationAuthorization() {
        // Check the authorization status and ask for permission if needed
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location access denied or restricted.")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation() // Start getting location updates
        @unknown default:
            break
        }
    }
    
    // Request current location
    func requestLocation() {
        manager.requestLocation()
    }
    
    // Delegate method for location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Save the coordinate to the published property
            self.coordinate = location.coordinate
            
            // Reverse geocode to get the place name
            lookUpCurrentLocation(for: location) { placemark in
                self.place = placemark
            }
        }
    }
    
    // Reverse geocoding to get the place name
    private func lookUpCurrentLocation(for location: CLLocation, completionHandler: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error during reverse geocoding: \(error.localizedDescription)")
                completionHandler(nil)
            } else if let placemark = placemarks?.first {
                let place = placemark.locality ?? "Unknown place"
                completionHandler(place)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    // Delegate method for handling location errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    // Respond to changes in location authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthorization() // Re-check permission status
    }
}
