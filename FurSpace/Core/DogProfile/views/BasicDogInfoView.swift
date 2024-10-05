import SwiftUI

struct BasicDogInfoView: View {
    let pets: Pets
    let user: User
    @State private var showExtraInfo: Bool = false // State for toggling extra info
    
    var body: some View {
        VStack {
            Spacer() // Push content to the bottom
            
            // Extra Information Section (Displayed above the name and breed)
            if showExtraInfo {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Pet Information")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Type: \(pets.type ?? "Unknown")")
                        .foregroundColor(.white)
                    
                    Text("Age: \(pets.age != nil ? "\(pets.age!) years old" : "Unknown age")")
                        .foregroundColor(.white)
                    
                    Text("Favorite Activity: \(pets.activities ?? "None")")
                        .foregroundColor(.white)
                    
                    Text("Owner: \(user.fullname ?? "owner name")") // Adjust or replace with dynamic owner name
                        .foregroundColor(.white)
                    
                    Text("Potty Trained: \(pets.isPottyTrained ?? false ? "Yes" : "No")")
                        .foregroundColor(.white)
                    
                    Text("Vaccinated: \(pets.isSpayedNeutered ?? false ? "Yes" : "No")") // Changed to spayed/neutered
                        .foregroundColor(.white)
                    
                    Text("Allowed on Furniture: \(pets.isFurnitureAllowed ?? false ? "Yes" : "No")")
                        .foregroundColor(.white)
                    
                    // Add more details as needed
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
                .transition(.move(edge: .bottom)) // Animation effect for showing extra info
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(pets.petname ?? "Please upload pet data")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(pets.breed ?? "Unknown breed")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                // Info button to show more details
                HStack {
                    Spacer() // Push the icon to the right
                    Button(action: {
                        // Toggle the extra info
                        withAnimation {
                            showExtraInfo.toggle()
                        }
                    }) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.4)) // Background for visibility
            .cornerRadius(10)
            .padding(.horizontal, 50)
        }
    }
}

#Preview {
    BasicDogInfoView(pets: mockPets[0], user: User.MOCK_USER[1])
}
