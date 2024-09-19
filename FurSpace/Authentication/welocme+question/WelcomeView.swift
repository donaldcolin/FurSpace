import SwiftUI

struct WelcomeView: View {
    @State private var isAgreedToTerms: Bool = false
    @EnvironmentObject var viewmodel: RegisterViewModel
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                // Image Section
                Image("fur")
                    .resizable()
                    .frame(width: 400, height: 440)
                    .padding(.top, 50)
                    .offset(y:40)
                
                Spacer()
                
                // Welcome Text
                Text("Welcome to Furspace")
                    .font(.title)
                    .bold()
                
                // Agree to Terms Toggle
                Toggle(isOn: $isAgreedToTerms) {
                    Text("I agree to the **Terms and Conditions**")
                }
                .padding(.horizontal)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                // Continue Button
                Button{
                    Task{try await viewmodel.createUser()}
                } label:{
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isAgreedToTerms ? Color.black : Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(!isAgreedToTerms)  // Disable button if terms are not agreed
                .padding(.bottom, 20)
                }
                .padding()
            }
        }}

#Preview {
    WelcomeView()
}

