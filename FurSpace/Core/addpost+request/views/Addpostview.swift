import SwiftUI
import PhotosUI

struct AddPostView: View {
    @State private var caption = ""
    @State private var location = ""
    @State private var showImagePicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            // Header with upload and cancel buttons
            HStack {
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Upload")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text("New Post")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    print("Cancel")
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            
            // Image and caption area
            HStack(alignment: .top, spacing: 15) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150) // Larger image preview
                        .cornerRadius(10)
                        .clipped()
                } else {
                    Image("placeholder") // Default placeholder image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 300) // Larger placeholder size
                        .cornerRadius(10)
                        .clipped()
                }
                
                // Ensure height matches the image size
            }
            .padding(.horizontal)
            
            
            // Select location field
            VStack {
                TextField("Enter your caption", text: $caption, axis: .vertical)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(height: 150)
                
                TextField("Select location", text: $location)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    )
            }
            .padding(.horizontal)

            Spacer()
        }
        .photosPicker(isPresented: $showImagePicker, selection: $selectedPhotoItem)
        .onChange(of: selectedPhotoItem) { newItem in
            if let newItem = newItem {
                Task {
                    if let imageData = try? await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: imageData) {
                        selectedImage = uiImage
                    }
                }
            }
        }
    }
}

#Preview {
    AddPostView()
}
