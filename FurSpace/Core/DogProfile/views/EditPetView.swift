import SwiftUI
import PhotosUI

struct EditPetView: View {
    @StateObject var viewModel: EditPetViewModel
    @Environment(\.dismiss) var dismiss
    let petTypes = ["Dog", "Cat", "Bird", "Others"]
    let genders = ["Male", "Female"]

    init(pet: Pets) {
        self._viewModel = StateObject(wrappedValue: EditPetViewModel(pet: pet))
    }

    var body: some View {
        NavigationView {
            Form {
                // Pet Image Section
                Section {
                    VStack {
                        if let petImage = viewModel.petimageurl {
                            petImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } else {
                            CircularPetImageView(pet: viewModel.pet, size: .medium)
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

                    // Picker for Pet Type
                    Picker("Select Pet Type", selection: $viewModel.type) {
                        ForEach(petTypes, id: \.self) { petType in
                            Text(petType)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if viewModel.type == "Others" {
                        TextField("Specify the pet", text: $viewModel.type)
                            .padding(.vertical)
                    }

                    TextField("Breed", text: $viewModel.breed)
                    TextField("Age", value: $viewModel.age, format: .number)

                    // Picker for Pet Gender
                    Picker("Gender", selection: $viewModel.gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
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
    EditPetView(pet: mockPets[0])
}
