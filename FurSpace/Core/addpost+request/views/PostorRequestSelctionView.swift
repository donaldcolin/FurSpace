import SwiftUI

struct PostorRequestSelectionView: View {
    @State private var tabIndex: Int = 0
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // 2x2 Grid of Tiles
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    
                    NavigationLink(destination: UploadPostView(tabIndex: $tabIndex)) {
                                    CustomRowView(buttonTitle: "Add a Post", backgroundColor: .white, backgroundImage: "dogpose")
                                }
                    
                    NavigationLink(destination: AddRequestView()) {
                        CustomRowView(buttonTitle: "Add a Request for Dog Boarding", backgroundColor: .green, backgroundImage: "dogfam")
                    }
                    
                    NavigationLink(destination: AddRequestView()) {
                        CustomRowView(buttonTitle: "Add a Request for Dog Walking", backgroundColor: .blue, backgroundImage: "dogwalk")
                    }
                    
                    NavigationLink(destination: DoctorRequestView()) {
                        CustomRowView(buttonTitle: "Get a Consult from a Vet", backgroundColor: .purple, backgroundImage: "vet")
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Select an Option")
        }
    }
}

struct CustomRowView: View {
    var buttonTitle: String
    var backgroundColor: Color
    var backgroundImage: String // Image name passed as a parameter
    
    var body: some View {
        ZStack {
            // Background Image
            Image(backgroundImage)
                .resizable()
                .scaledToFill() // Ensures the image fills the tile
                .frame(width: 160, height: 280) // Same size as the tile
                .clipped() // Ensures the image does not overflow
            
            // Overlay for semi-transparency over the background image
            Color.black.opacity(0.1) // A darker overlay to improve text visibility
            
            VStack {
                Spacer()
                
                // Adding a semi-transparent background to the text
                Text(buttonTitle)
                    .bold()
                    .font(.headline)
                    .foregroundColor(.white) // White color for better contrast
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10) // Add padding to the text
                    .background(Color.black.opacity(0.3)) // Background to enhance readability
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                
                //Spacer()

            }
        }
        .frame(width: 160, height: 300) // Adjusted button size for grid
        .cornerRadius(20)
        .shadow(radius: 5)
    }}
#Preview {
    PostorRequestSelectionView()
}
