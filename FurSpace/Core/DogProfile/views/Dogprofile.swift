import SwiftUI
import Kingfisher

struct Dogprofile: View {
    let pest: Pets
    let user : User
    
    // State variables to handle the edit view
    @State private var showEditPetView: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // KFImage with valid URL or fallback to a placeholder
            KFImage(URL(string: pest.petimageurl ?? "https://via.placeholder.com/300"))
                .resizable()
                .placeholder {
                    ProgressView() // Show a loading indicator while the image is loading
                }
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Foreground Content
            VStack {
                BasicDogInfoView(pets: pest, user: user)
                    .padding()
            }

            // Edit button at the top right corner
            VStack {
                HStack {
                    Spacer()
                    Button {
                        // Show the EditPetView as a fullscreen cover
                        showEditPetView = true
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 20)
                            .padding(.top, 20)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showEditPetView) {
            // Launch the edit pet view as fullscreen cover
            EditPetView(pet: pest)
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
    Dogprofile(pest: mockPet, user: User.MOCK_USER[0])
}
