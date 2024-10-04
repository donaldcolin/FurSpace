import SwiftUI
import Kingfisher

struct Dogprofile: View {
    let pest: Pets

    // State variable to toggle extra info visibility
    @State private var showExtraInfo: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Use a valid URL or a placeholder image if petimageurl is nil
            if let imageUrl = pest.petimageurl, let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        ProgressView() // Show a loading indicator while the image is loading
                    }
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                // Fallback image if petimageurl is nil or invalid
                Image("vet") // Ensure you have a "vet" image in your assets
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            // Foreground Content
            VStack {
                BasicDogInfoView(pets: pest) // Pass the single `pest` instance
                    .padding()
            }
        }
    }
    
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    private var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.30
    }
}

#Preview {
    // Provide a mock Pets object for the preview
    let mockPet = Pets(
        id: "1",
        ownerUID: "owner1",
        petimageurl: "https://picsum.photos/200/300", // Ensure this is a valid URL
        petname: "Buddy",
        activities: nil,
        age: 3,
        breed: "Golden Retriever",
        gender: "Male",
        type: "Dog",
        isPottyTrained: true,
        isSpayedNeutered: false,
        isFurnitureAllowed: true,
        user: nil
    )
    
    Dogprofile(pest: mockPet)
}
