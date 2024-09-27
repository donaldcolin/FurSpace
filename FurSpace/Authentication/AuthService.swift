//
//  AuthService.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import Foundation
import FirebaseAuth
import MapKit
import FirebaseFirestore

class AuthService{
    @Published var userSession : FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init (){
        self.userSession = Auth.auth().currentUser
    }
    @MainActor
    func Login(withEmail email : String , password : String)async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password : password)
            self.userSession = result.user
        }catch{
            print("error: \(error.localizedDescription)")
        }
    }
    @MainActor
    func createuser(email : String, password : String,username : String,bio : String,fullname : String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            //uploaduser data here
            self.userSession = result.user
            
            await uploadUderData(uid: result.user.uid, email: email, username:username, bio: bio,fullname: fullname)
        }catch{
            print("error: \(error.localizedDescription)")
        }
        
    }
    func loaduserdata() async throws{
        
        
    }
    func LogOut(){
        
        try? Auth.auth().signOut()
        self.userSession = nil
    }
}

func updateUserdetails(){
    
    
}

private func uploadUderData(uid : String, email: String, username : String,bio : String,fullname : String) async{
    let user = User(id: uid, username: username, profileimageurl: nil, email: email, fullname: fullname, bio: bio, coordinate: CLLocationCoordinate2D(), pets: [])
    guard let encodeuser = try? Firestore.Encoder().encode(user) else {return}
    
    try? await Firestore.firestore().collection("users").document(uid).setData(encodeuser)
}

