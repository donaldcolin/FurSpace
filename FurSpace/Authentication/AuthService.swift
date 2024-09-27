//
//  AuthService.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore
import MapKit

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createuser(email: String, password: String, username: String, bio: String, fullname: String, coordinate: CLLocationCoordinate2D) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // Save user session
            self.userSession = result.user
            
            // Upload user data to Firestore including the coordinates
            await uploadUserData(uid: result.user.uid, email: email, username: username, bio: bio, fullname: fullname, coordinate: coordinate)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func uploadUserData(uid: String, email: String, username: String, bio: String, fullname: String, coordinate: CLLocationCoordinate2D) async {
        // Create a new user object with all details including coordinates
        let user = User(
            id: uid,
            username: username,
            profileimageurl: nil,
            email: email,
            fullname: fullname,
            bio: bio,
            coordinate: coordinate,  // Save the user's location
            pets: []
        )
        
        // Encode the user object
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {
            print("Failed to encode user.")
            return
        }
        
        // Upload the encoded user to Firestore
        do {
            try await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
            print("User data uploaded successfully!")
        } catch {
            print("Failed to upload user data: \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws {
        // Implement loading user data logic here
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
}
