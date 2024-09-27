//
//  RegisterViewmodel.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

import Foundation
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
    @Published var location = ""
    @Published var coordinate: CLLocationCoordinate2D?
    init() {self.coordinate = CLLocationCoordinate2D()}
    
    
    @MainActor
    func createUser() async throws{
        try await AuthService.shared.createuser(email: email, password: password, username: username, bio: bio,fullname: fullname)
        
        fullname = ""
        email = ""
        password = ""
        errorMessage = ""
        bio = ""
        username = ""
        }
    }

//    private func insertUserRecord(id: String) {
//        //let newUser = User(id: id, name: name, email: email)
//
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(id)
//            .setData(newUser.asDictionary()) { [weak self] error in
//                if let error = error {
//                    self?.errorMessage = "Failed to save user data: \(error.localizedDescription)"
//                }
//            }
//    }

//    func validate() -> Bool {
//        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
//           email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
//           password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            errorMessage = "Please enter your name, email, and password."
//            return false
//        } else if !isValidEmail(email) {
//            errorMessage = "Please enter a valid email address."
//            return false
//        }
//        return true
//    }
//
//    func isValidEmail(_ email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        return emailPred.evaluate(with: email)
//    }
//}
