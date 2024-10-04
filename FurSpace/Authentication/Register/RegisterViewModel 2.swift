import Foundation
import MapKit
import FirebaseAuth
class RegisterViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
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
        
        // Check if all required fields are filled
        guard !fullname.isEmpty, !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            errorMessage = "All fields are required"
            return
        }

        // Create the user by passing all parameters to the AuthService
        try await AuthService.shared.createuser(
            email: email,
            password: password,
            username: username,
            bio: bio,
            fullname: fullname,
            coordinate: userCoordinate
    
        )
        
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
