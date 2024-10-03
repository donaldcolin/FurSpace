import Foundation
import FirebaseAuth
import MapKit
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
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
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Upload user data
            await uploadUserData(
                uid: result.user.uid,
                email: email,
                username: username,
                bio: bio,
                fullname: fullname,
                coordinate: coordinate
            )
            
            // Upload pet data
           
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserdata() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUId = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withuid: currentUId)
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
    
    func LogOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    }
