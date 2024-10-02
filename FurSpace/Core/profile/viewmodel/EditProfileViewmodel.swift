//
//  EditProfileViewmodel.swift
//  FurSpace
//
//  Created by Donald Colin on 01/10/24.
//


import Firebase
import PhotosUI
import SwiftUI

class EditProfileViewmodel: ObservableObject {
    @Published var user : User
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    
    @Published var postImage: Image?
    @Published var fullname = ""
    @Published var username = ""
    @Published var bio = ""
    
    init(user :User){
        self.user = user
        
        if let username = user.username{
            self.username = username
        }
        if let bio = user.bio{
            self.bio = bio
        }
        if let fullname = user.fullname{
            self.fullname = fullname
        }

    }
    
    
    private var uiImage: UIImage?
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws{
        var data = [String:Any]()
        
        
        if let uiImage = uiImage{
            let imageUrl = try await ImageUploader.uploadImage(image: uiImage)
            data["profileimageurl"] = imageUrl
        }
        
        // add image change
        if !fullname.isEmpty && user.fullname != fullname{
            data["fullname"] = fullname
        }
        if !bio.isEmpty && user.bio  != bio{
            data["bio"] = bio
        }
        if !username.isEmpty && user.username != username{
            data["username"] = username
            
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
