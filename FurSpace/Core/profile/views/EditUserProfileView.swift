import SwiftUI
import PhotosUI

struct EditUserProfileView: View {
    @StateObject var viewModel : EditProfileViewmodel
    @Environment(\.dismiss) var dismiss
    init(user :User){

        self._viewModel = StateObject(wrappedValue: EditProfileViewmodel(user: user))
    }
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
                            CircularProfileImageView(user: viewModel.user, size: .large)
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
                        Task {try await viewModel.updateUserData()
                            dismiss()}
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Edit Profile")
        }
    }

    
}

#Preview {
    EditUserProfileView(user: User.MOCK_USER[0])
}
