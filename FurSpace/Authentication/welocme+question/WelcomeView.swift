import SwiftUI

struct WelcomeView: View {
    @State private var isAgreedToTerms: Bool = false
    @EnvironmentObject var viewModel: RegisterViewModel // Make sure it's environmentObject
    @StateObject private var petViewModel = PetQuestionViewModel()
    @State private var showErrorMessage: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Image Section
                Image("fur")
                    .resizable()
                    .frame(width: 400, height: 440)
                    .padding(.top, 50)
                    .offset(y: 40)

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

                // Error Message Section
                if showErrorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom)
                }

                // Continue Button
                Button {
                    Task {
                        do {
                            // Create user first
                            try await viewModel.createUser()
                            print("Uploaded USER DATA")

                            // After user creation, upload pet data
                            if let userId = viewModel.userSession?.uid { // Access userSession directly from viewModel
                                // Set the owner ID in the petViewModel
                                petViewModel.ownerId = userId // Assuming you have an ownerId property in PetQuestionViewModel
                                try await petViewModel.uploadpets()
                                print("Uploaded PET DATA")
                            }
                        } catch {
                            showErrorMessage = true
                            errorMessage = "Failed to complete registration: \(error.localizedDescription)"
                            print(errorMessage)
                        }
                    }
                } label: {
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
    }
}
