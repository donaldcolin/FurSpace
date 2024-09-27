import SwiftUI
import CoreLocationUI

struct CustomButtonLocation: View {
    // Declare @StateObject for the location manager
    @StateObject var locationManager = LocationManage()
    @ObservedObject var viewModel: RegisterViewModel // Pass the RegisterViewModel

    var body: some View {
        HStack {
            if let coordinate = locationManager.coordinate {
                // Show the latitude and longitude if available
                Text("please aloow your loaction ")
                    .padding()
                
                // Pass coordinates to viewModel when available
                //viewModel.coordinate = coordinate
            } else {
                Text("Location Unavailable") // Placeholder text when location is not fetched yet
                    .padding()
            }

            // The button for requesting the current location
            LocationButton(.currentLocation) {
                locationManager.requestLocation()
            }
            .labelStyle(.iconOnly) // Customize button appearance
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            locationManager.requestLocationAuthorization() // Request location permission on view load
        }
    }
}

#Preview {
    CustomButtonLocation(viewModel: RegisterViewModel())
}
