//
//  EditPetViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 04/10/24.
//


import Firebase
import PhotosUI
import SwiftUI

class EditPetViewModel: ObservableObject {
    @Published var pet: Pets
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    
    @Published var petimageurl: Image?
    @Published var petname = ""
    @Published var type = ""
    @Published var breed = ""
    @Published var isFurnitureAllowed = false
    @Published var isPottyTrained = false
    @Published var isSpayed = false
    @Published var age = 0
    @Published var activities = ""
    @Published var gender = ""

    private var uiImage: UIImage?

    init(pet: Pets) {
        self.pet = pet
        
        if let petname = pet.petname {
            self.petname = petname
        }
        if let type = pet.type {
            self.type = type
        }
        if let breed = pet.breed {
            self.breed = breed
        }
        if let age = pet.age {
            self.age = age
        }
        if let activities = pet.activities {
            self.activities = activities
        }
        if let gender = pet.gender {
            self.gender = gender
        }
        self.isFurnitureAllowed = pet.isFurnitureAllowed ?? false
        self.isPottyTrained = pet.isPottyTrained ?? false
        self.isSpayed = pet.isSpayedNeutered ?? false
    }
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.petimageurl = Image(uiImage: uiImage)
    }

    func updatePetData() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try await PetImageUploader.uploadImage(image: uiImage)
            data["petimageurl"] = imageUrl
        }
        
        if !petname.isEmpty && pet.petname != petname {
            data["petname"] = petname
        }
        if !type.isEmpty && pet.type != type {
            data["type"] = type
        }
        if !breed.isEmpty && pet.breed != breed {
            data["breed"] = breed
        }
        if age > 0 && pet.age != age {
            data["age"] = age
        }
        if !activities.isEmpty && pet.activities != activities {
            data["activities"] = activities
        }
        if !gender.isEmpty && pet.gender != gender {
            data["gender"] = gender
        }
        if pet.isFurnitureAllowed != isFurnitureAllowed {
            data["isFurnitureAllowed"] = isFurnitureAllowed
        }
        if pet.isPottyTrained != isPottyTrained {
            data["isPottyTrained"] = isPottyTrained
        }
        if pet.isSpayedNeutered != isSpayed {
            data["isSpayed"] = isSpayed
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("pets").document(pet.id).updateData(data)
        }
    }
}
