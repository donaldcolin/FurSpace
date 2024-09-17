//
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            // Illustration Image
            Image("fur")
                .resizable()
                .scaledToFit()
                .frame( height: 220)
                .padding(.top, 40)
            
            // Log-in Text
            Text("Log-in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
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
            .padding(.top, 20)
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
            
            // Forgot Password Button
            Button(action: {
                // Forgot password action
            }) {
                Text("Forget password?")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 30)
            
            // Login Button
            Button(action: {
                // Login action
            }) {
                Text("Login")
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
            
            // Sign-up Text
            HStack {
                Text("Don’t have an account?")
                Button(action: {
                    // Sign-up action
                }) {
                    Text("Sign-up")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 20)
            
            // Social Media Login Options
            Text("Or login with")
                .padding(.top, 20)
            
            HStack {
                Button(action: {
                    // Gmail login action
                }) {
                    Image("google")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                }
                
               
            }
            .padding(.top, 10)
        }
        .frame(maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
