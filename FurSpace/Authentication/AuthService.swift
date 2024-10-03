import Foundation
import FirebaseAuth
import MapKit
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var currentpet: Pets?
    
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
        coordinate: CLLocationCoordinate2D,
        petname: String,
        age: Int,
        breed: String,
        gender: String,
        type: String,
        ispotty: Bool,
        isfurniture: Bool,
        isSpayedNeutered: Bool,
        isVaccinated: Bool
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
            try await uploadPetdata(
                uid: result.user.uid,
                ownerid: result.user.uid,
                petname: petname,
                age: age,
                breed: breed,
                gender: gender,
                type: type,
                ispotty: ispotty,
                isfurniture: isfurniture,
                isVaccinated: isVaccinated,
                isspayed: isSpayedNeutered
            )
            
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
    
    func uploadPetdata(
        uid: String,
        ownerid: String,
        petname: String,
        age: Int,
        breed: String,
        gender: String,
        type: String,
        ispotty: Bool,
        isfurniture: Bool,
        isVaccinated: Bool,
        isspayed: Bool
    ) async throws {
        let postRef = Firestore.firestore().collection("pets").document()
        let pets = Pets(
            id: postRef.documentID,
            ownerUID: uid,
            petname: petname,
            age: age,
            breed: breed,
            gender: gender,
            type: type,
            isPottyTrained: ispotty,
            isSpayedNeutered: isspayed,
            isFurnitureAllowed: isfurniture
        )
        self.currentpet = pets
        guard let encodedPost = try? Firestore.Encoder().encode(pets) else { return }
        try await postRef.setData(encodedPost)
    }
}
