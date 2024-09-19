//
//  AuthService.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import Foundation
import FirebaseAuth

class AuthService{
    @Published var userSession : FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init (){
        self.userSession = Auth.auth().currentUser
    }
    func Login(withEmail email : String , password : String)async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password : password)
            self.userSession = result.user
        }catch{
            print("error: \(error.localizedDescription)")
        }
    }
    func createuser(email : String, password : String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
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

