import SwiftUI
import PhotosUI

struct PetQuestionnaireView: View {
    @StateObject private var viewModel = PetQuestionViewModel()
    @State private var isImagePickerPresented: Bool = false
    @State private var showErrorMessage: Bool = false
    @State private var isWelcomeViewPresented: Bool = false // State for navigation
    let petTypes = ["Dog", "Cat", "Bird", "Others"]
    let genders = ["Male", "Female"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Pet Information Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pet Information")
                            .font(.title2)
                            .bold()

                        // Picker for Pet Type
                        Picker("What pet do you own?", selection: $viewModel.type) {
                            ForEach(petTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical)

                        if viewModel.type == "Others" {
                            TextField("Specify the pet", text: $viewModel.type)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                        }

                        TextField("Breed of Pet", text: $viewModel.breed)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)

                        TextField("Pet Name", text: $viewModel.petname)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)

                        TextField("Pet Age (in years)", text: Binding(
                            get: {
                                String(viewModel.age)  // Convert Int to String for display
                            },
                            set: { newValue in
                                viewModel.age = Int(newValue) ?? 0  // Convert String back to Int
                            }
                        ))
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding()

                        // Image Picker Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Upload Pet Image")
                                .font(.title2)
                                .bold()

                            HStack(spacing: 8) {
                                if let image = viewModel.postImage {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(8)
                                }
                                Button(action: {
                                    isImagePickerPresented.toggle()
                                }) {
                                    Text("Select Image")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.vertical)
                        }
                        .photosPicker(isPresented: $isImagePickerPresented, selection: $viewModel.selectedImage)

                        // Additional Details Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Additional Details")
                                .font(.title2)
                                .bold()

                            Toggle(isOn: $viewModel.isFurnitureAllowed) {
                                Text("Is furniture allowed?")
                            }
                            .padding(.vertical)

                            Toggle(isOn: $viewModel.isPottyTrained) {
                                Text("Is the pet potty trained?")
                            }
                            .padding(.vertical)

                            Toggle(isOn: $viewModel.isSpayedNeutered) {
                                Text("Is the pet spayed/neutered?")
                            }
                            .padding(.vertical)
                        }
                        .padding()

                        // Pet Activities Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Pet Activities")
                                .font(.title2)
                                .bold()

                            TextField("Activities your pet enjoys", text: $viewModel.activities)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                        .padding()

                        // Pet Gender Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Pet Gender")
                                .font(.title2)
                                .bold()

                            Picker("Gender of Pet", selection: $viewModel.gender) {
                                ForEach(genders, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical)
                        }
                        .padding()

                        // Validation Error Message
                        if showErrorMessage {
                            Text("Error uploading pet details. Please try again.")
                                .foregroundColor(.red)
                                .padding(.bottom)
                        }

                        // Upload Button
                        Button(action: {
                            Task {
                                do {
                                   // try await viewModel.uploadpets()
                                    isWelcomeViewPresented = true // Only set to true after successful upload
                                } catch {
                                    print("Error uploading pet details")
                                    showErrorMessage = true
                                }
                            }
                        }) {
                            Text("Sign Up")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 44)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                        // Navigation to WelcomeView when upload is successful
                        NavigationLink(
                            destination: WelcomeView(), // Replace with your actual welcome view
                            isActive: $isWelcomeViewPresented,
                            label: { EmptyView() }
                        )
                    }
                }
            }
        }
    }
}
