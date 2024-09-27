//
//  RegisterViewModel 2.swift
//  FurSpace
//
//  Created by Donald Colin on 28/09/24.
//


import Foundation
import MapKit

class RegisterViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    @Published var bio = ""
    @Published var username = ""
    @Published var profileImage: Data?
    @Published var coordinate: CLLocationCoordinate2D? // Updated to hold user's coordinates

    init() {
        self.coordinate = CLLocationCoordinate2D() // Default value
    }
    
    @MainActor
    func createUser() async throws {
        guard let userCoordinate = coordinate else {
            errorMessage = "Location not available"
            return
        }
        
        // Pass coordinate to the createUser method
        try await AuthService.shared.createuser(email: email, password: password, username: username, bio: bio, fullname: fullname, coordinate: userCoordinate)
        
        // Reset fields after user creation
        fullname = ""
        email = ""
        password = ""
        confirmPassword = ""
        bio = ""
        username = ""
        errorMessage = ""
    }
}