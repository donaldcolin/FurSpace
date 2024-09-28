import SwiftUI

struct EditProfile: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Image with Edit Icon
                ZStack(alignment: .bottomTrailing) {
                    Image("luffy") // Replace with the actual user image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    // Edit Icon
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        )
                }
                
                // Name and Email
                VStack(spacing: 5) {
                    Text("Donald Colin") // Replace with dynamic username
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Donaldcolin.com") // Replace with dynamic email
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Edit Profile Button
                Button(action: {
                    // Edit profile action
                }) {
                    Text("Edit Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                // Settings List
                VStack(spacing: 15) {
                    ProfileOptionRow(iconName: "gearshape", text: "Settings") {
                        // Settings action
                    }
                    ProfileOptionRow(iconName: "creditcard", text: "Billing Details") {
                        // Billing details action
                    }
                    ProfileOptionRow(iconName: "tick.fill", text: "Get verified") {
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
        AuthService.shared.LogOut()
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
    EditProfile()
}
