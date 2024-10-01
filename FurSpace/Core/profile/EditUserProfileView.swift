import SwiftUI
import PhotosUI

struct EditUserProfileView: View {
    @StateObject private var viewModel = EditProfileViewmodel()

    var body: some View {
        NavigationView {
            Form {
                // Profile Picture
                Section {
                    VStack {
                        if let postImage = viewModel.postImage {
                            postImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        }

                        PhotosPicker(selection: $viewModel.selectedImage, matching: .images) {
                            Text("Change Profile Photo")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // Name, Username, Bio, Location fields
                Section(header: Text("Personal Info")) {
                    TextField("Full Name", text: $viewModel.fullname)
                    TextField("Username", text: $viewModel.username)
                    TextField("Bio", text: $viewModel.bio)
                }

                // Save Button
                Section {
                    Button(action: {
                        // Handle saving logic here
                        saveProfile()
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Edit Profile")
        }
    }

    func saveProfile() {
        // Add logic to save the profile details
        print("Profile saved with name: \(viewModel.fullname), username: \(viewModel.username), bio: \(viewModel.bio)")
    }
}

#Preview {
    EditUserProfileView()
}
