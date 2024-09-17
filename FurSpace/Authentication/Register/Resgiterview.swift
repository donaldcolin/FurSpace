import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            // Illustration Image
            Image("fur")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.top, 50)
            
            // Sign-up Text
            Text("Sign-up")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            
            // Name Field
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                TextField("Your name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .autocapitalization(.words)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)
            
            // Email Field
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                TextField("Your email id", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .padding(.top, 10)
            .padding(.horizontal, 30)
            
            // Password Field
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                HStack {
                    SecureField("Password", text: $password)
                    Button(action: {
                        // Action to toggle visibility
                    }) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 30)
            
            // Confirm Password Field
            VStack(alignment: .leading) {
                Text("Confirm Password")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                HStack {
                    SecureField("Confirm Password", text: $confirmPassword)
                    Button(action: {
                        // Action to toggle visibility
                    }) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 30)
            
            // Sign-up Button
            Button(action: {
                // Sign-up action
            }) {
                Text("Sign-up")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)
            
            // Login Option
            HStack {
                Text("Already have an account?")
                Button(action: {
                    // Go to Login action
                }) {
                    Text("Log-in")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
