import SwiftUI

struct Dogprofile: View {
    let pest: pets
    var dogImage: String = "doggy" // Replace with dynamic dog image
    
    // State variable to toggle extra info visibility
    @State private var showExtraInfo: Bool = false
    
    var body: some View {
        ZStack {
            // Fixed Background Image
            Image(pest.petimageurl ?? "placeholder") // Use `pest` instead of `pets`
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all) // Fill the entire background
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Gradient Overlay at the bottom
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.3), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .edgesIgnoringSafeArea(.all) // Apply the gradient over the entire screen
            
            // Foreground Content
            VStack {
                BasicDogInfoView(pets: pest) // Pass the single `pest` instance, not `mockPets`
                    .padding()
            }
        }
    }
}



#Preview {
    Dogprofile(pest: mockPets[1])
}
