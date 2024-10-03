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
    
    // PET DATA
    @Published var petType: String = "Dog"
    @Published var otherPetType: String = ""
    @Published var isVaccinated: Bool = false
    @Published var isSpayedNeutered: Bool = false
    @Published var activities: String = ""
    @Published var petname = ""
    @Published var age: Int = 0
    @Published var breed = ""
    @Published var gender = ""
    @Published var ispotty: Bool = false
    @Published var isfurniture: Bool = false
    
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
            coordinate: userCoordinate,
            petname: petname,
            age: age,
            breed: breed,
            gender: gender,
            type: petType, // Pet type
            ispotty: ispotty,
            isfurniture: isfurniture,
            isSpayedNeutered: isSpayedNeutered,
            isVaccinated: isVaccinated
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
