import SwiftUI
import MapKit

struct LocationSearchView: View {
    let users: [User] // Accept an array of users
    @State private var searchText: String = ""
    @State private var annotations: [MKPointAnnotation] = []
    
    var body: some View {
        VStack {
            TextField("Search locations to view other users", text: $searchText, onCommit: {
                searchLocation()
            })
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            MapView(annotations: $annotations)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            addUsersToMap()
        }
    }
    
    private func searchLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { (placemarks, error) in
            if let placemarks = placemarks, let location = placemarks.first?.location {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = searchText
                annotations = [annotation]
            }
        }
    }
    
    private func addUsersToMap() {
        for user in users { // Loop through the array of users
            let annotation = MKPointAnnotation()
            annotation.coordinate = user.coordinate
            //annotation.title = "\(user.fullname ?? user.username) (\(user.userType))"
            annotations.append(annotation)
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator // Set the delegate
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // Customize annotation views
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "UserLocation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
    }
}
