//
//  EditPetView.swift
//  FurSpace
//
//  Created by Donald Colin on 04/10/24.
//


import SwiftUI
import PhotosUI

struct EditPetView: View {
    @StateObject var viewModel: EditPetViewModel
    @Environment(\.dismiss) var dismiss
    
    init(pet: Pets) {
        self._viewModel = StateObject(wrappedValue: EditPetViewModel(pet: pet))
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Pet Image Section
                Section {
                    VStack {
                        if let petImage = viewModel.petImage {
                            petImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } else {
                            Text("") // Placeholder for pet image
                        }

                        PhotosPicker(selection: $viewModel.selectedImage, matching: .images) {
                            Text("Change Pet Photo")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // Pet Info Section
                Section(header: Text("Pet Info")) {
                    TextField("Pet Name", text: $viewModel.petname)
                    TextField("Type", text: $viewModel.type)
                    TextField("Breed", text: $viewModel.breed)
                    TextField("Age", value: $viewModel.age, format: .number)
                    TextField("Activities", text: $viewModel.activities)
                    TextField("Gender", text: $viewModel.gender)
                }

                // Pet Preferences Section
                Section(header: Text("Preferences")) {
                    Toggle("Allowed on Furniture", isOn: $viewModel.isFurnitureAllowed)
                    Toggle("Potty Trained", isOn: $viewModel.isPottyTrained)
                    Toggle("Spayed/Neutered", isOn: $viewModel.isSpayed)
                }

                // Save Button
                Section {
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.updatePetData()
                                dismiss()
                            } catch {
                                print("Error updating pet data: \(error.localizedDescription)")
                            }
                        }
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Edit Pet")
        }
    }
}

#Preview {
    EditPetView(pet:mockPets[0])
}
