//
//  CustomButtonLocation.swift
//  FurSpace
//
//  Created by Donald Colin on 27/09/24.
//


import SwiftUI
import CoreLocationUI

struct CustomButtonLocation: View {
    // Declare @StateObject here at the struct level
    @StateObject var locationManager = LocationManage()

    var body: some View {
        HStack {
            if let place = locationManager.place {
                Text("\(place)") // Show the place if available
                    .padding()
            } else {
                Text("Location Unavailable") // Placeholder text
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
    CustomButtonLocation()
}
