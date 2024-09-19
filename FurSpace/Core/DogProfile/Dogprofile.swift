import SwiftUI

struct Dogprofile: View {
    let pest: Pets
    var dogImage: String = "doggy" // Replace with dynamic dog image
    
    // State variable to toggle extra info visibility
    @State private var showExtraInfo: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            // Fixed Background Image
            Image(pest.petimageurl ?? "vet") // Use `pest` instead of `pets`
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            // Foreground Content
            VStack {
                BasicDogInfoView(pets: pest) // Pass the single `pest` instance, not `mockPets`
                    .padding()
                
            }
        }
    }
}

private extension Dogprofile {
    var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.30
    }
}

#Preview {
    Dogprofile(pest: mockPets[1])
}
