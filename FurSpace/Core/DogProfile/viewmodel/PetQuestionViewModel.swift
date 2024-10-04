//
//  PetQuestionViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 03/10/24.
//
import Firebase
import PhotosUI
import SwiftUI
import FirebaseAuth

class PetQuestionViewModel: ObservableObject {
    @Published var ownerId: String?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    
    @Published var postImage: Image? // Image to show in the view
    @Published var petname: String = "" // Pet's name
    @Published var gender: String = ""  // Pet's gender
    @Published var breed: String = ""   // Pet's breed
    @Published var age: Int = 0         // Pet's age
    @Published var type: String = ""    // Pet's type (e.g., Dog, Cat)
    @Published var activities: String = "" // Pet's activities
    @Published var isPottyTrained: Bool = false // Whether the pet is potty trained
    @Published var isSpayedNeutered: Bool = false // Whether the pet is spayed/neutered
    @Published var isFurnitureAllowed: Bool = false // Whether the pet is allowed on furniture
    
    private var uiImage: UIImage? // Holds the image to be uploaded

    // Function to load the image from the PhotosPickerItem
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage) // Display the image in the view
    }
    
    // Function to upload pet data along with the image
    func uploadpets() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: User not authenticated")
            return
        }
        guard let uiImage = self.uiImage else {
            print("Error: No image selected")
            return
        }

        // Generate a reference to a new pet document in Firestore
        let petRef = Firestore.firestore().collection("pets").document()

        do {
            // Upload the image and get the URL
            guard let imageUrl = try await PetImageUploader.uploadImage(image: uiImage) else {
                print("Error: Image upload failed")
                return
            }
            
            // Create a new pet object
            let pet = Pets(
                id: petRef.documentID,
                ownerUID: uid,
                petimageurl: imageUrl,
                petname: petname,
                activities: activities,
                age: age,
                breed: breed,
                gender: gender,
                type: type,
                isPottyTrained: isPottyTrained,
                isSpayedNeutered: isSpayedNeutered,
                isFurnitureAllowed: isFurnitureAllowed
            )
            
            // Encode the pet object and upload it to Firestore
            let encodedPet = try Firestore.Encoder().encode(pet)
            try await petRef.setData(encodedPet)
            print("Pet details successfully uploaded to Firestore")
            
        } catch {
            print("Error uploading pet details: \(error.localizedDescription)")
        }
    }
}

