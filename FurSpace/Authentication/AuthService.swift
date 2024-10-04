import Foundation
import FirebaseAuth
import MapKit
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var currentPet: Pets?
    
    static let shared = AuthService()
    
    init() {
        Task {
            try await loadUserdata()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserdata()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createuser(
        email: String,
        password: String,
        username: String,
        bio: String,
        fullname: String,
        coordinate: CLLocationCoordinate2D
    ) async throws {
        do {
            // Create the user in Firebase Authentication
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Get the user's UID (ownerUID)
            guard let ownerUID = self.userSession?.uid else {
                throw URLError(.badServerResponse)
            }
            
            // Step 1: Upload user data to Firestore
            await uploadUserData(
                uid: ownerUID,  // Pass the UID of the user as ownerUID
                email: email,
                username: username,
                bio: bio,
                fullname: fullname,
                coordinate: coordinate
            )
            
            // Step 2: Upload pet data to Firestore using the owner's UID
            try await uploadPetData(ownerUID: ownerUID)
           
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserdata() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUID = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withuid: currentUID)
    }
    
    @MainActor
    private func uploadUserData(
        uid: String,
        email: String,
        username: String,
        bio: String,
        fullname: String,
        coordinate: CLLocationCoordinate2D
    ) async {
        let user = User(id: uid, username: username, profileimageurl: nil, email: email, fullname: fullname, bio: bio, coordinate: coordinate)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    @MainActor
    func uploadPetData(ownerUID: String) async throws {
        // Create a new document in the pets collection and get the document ID
        let petID = Firestore.firestore().collection("pets").document().documentID
        
        // Create a dictionary with just the id and ownerUID fields
        let petData: [String: Any] = [
            "id": petID,
            "ownerUID": ownerUID
        ]
        
        // Try uploading the data to the pets collection
        do {
            try await Firestore.firestore().collection("pets").document(petID).setData(petData)
            print("Pet data uploaded successfully with ID: \(petID)")
        } catch {
            print("Error uploading pet data: \(error.localizedDescription)")
        }
    }
}
