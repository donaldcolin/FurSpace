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
   // @Published var fullname = ""
    
    
   // private var uiImage: UIImage?
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
       // self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
}
