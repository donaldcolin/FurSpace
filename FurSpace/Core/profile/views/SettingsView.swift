import SwiftUI

struct SettingsView: View {
    let user: User
    
    // State variable to control fullScreenCover presentation
    @State private var isEditProfilePresented = false
    @State private var isQuestionsPresented = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                CircularProfileImageView(user: user, size: .large)
                
                // Name and Email
                VStack(spacing: 5) {
                    Text(user.fullname ?? "unk") // Replace with dynamic username
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                // Edit Profile Button
                Button(action: {
                    isEditProfilePresented = true
                }) {
                    Text("Edit Profile your profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .fullScreenCover(isPresented: $isEditProfilePresented) {
                    EditUserProfileView(user: user) // Present EditProfileView as full screen
                }
               
                // Settings List
                VStack(spacing: 15) {
                    ProfileOptionRow(iconName: "gearshape", text: "Settings") {
                        // Settings action
                    }
                    ProfileOptionRow(iconName: "creditcard", text: "Billing Details") {
                        // Billing details action
                    }
                    ProfileOptionRow(iconName: "house.fill", text: "Get verified") {
                        // User management action
                    }
                    ProfileOptionRow(iconName: "pawprint.fill", text: "Register as a pet walker or a boarder") {
                        // Information action
                    }
                    ProfileOptionRow(iconName: "stethoscope", text: "Register as a vet") {
                        // Information action
                    }
                    
                    // Logout Button
                    ProfileOptionRow(iconName: "arrowshape.turn.up.left.fill", text: "Logout", isDestructive: true) {
                        // Logout action
                        logout()
                    }
                }
                .padding(.top, 20)
            }
            .padding(.top, 40) // Adjusts space for top padding
        }
    }
    
    func logout() {
        // Implement logout functionality here
        AuthService.shared.logOut()
    }
}

struct ProfileOptionRow: View {
    var iconName: String
    var text: String
    var isDestructive: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(isDestructive ? .red : .blue)
                    .font(.title3)
                    .frame(width: 35, height: 35)
                    .background(isDestructive ? Color.clear : Color.blue.opacity(0.2))
                    .clipShape(Circle())
                
                Text(text)
                    .foregroundColor(isDestructive ? .red : .primary)
                    .fontWeight(isDestructive ? .semibold : .regular)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SettingsView(user: User.MOCK_USER[0])
}
