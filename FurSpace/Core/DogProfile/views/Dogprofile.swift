import SwiftUI

struct Dogprofile: View {
    let pest: Pets
    // State variable to toggle extra info visibility
    @State private var showExtraInfo: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            // Fixed Background Image
            if pest.user != nil{
                PetPhoto(pets: pest)
            }
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
