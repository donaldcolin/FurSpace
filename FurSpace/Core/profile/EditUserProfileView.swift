import SwiftUI

struct EditUserProfileView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var bio: String = ""
    @State private var location: String = ""
    @State private var profileImage: Image? = Image(systemName: "person.circle")
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            Form {
                // Profile Picture
                Section {
                    VStack {
                        profileImage?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .onTapGesture {
                                showingImagePicker = true
                            }

                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("Change Profile Photo")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // Name, Username, Bio, Location fields
                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $name)
                    TextField("Username", text: $username)
                    TextField("Bio", text: $bio)
                    TextField("Location", text: $location)
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
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }

    func saveProfile() {
        // Add logic to save the profile details
    }
}

#Preview {
    EditUserProfileView()
}
