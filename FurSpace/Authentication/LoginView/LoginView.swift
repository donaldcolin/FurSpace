import SwiftUI

struct LoginView: View {
    @StateObject var viewmodel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Illustration Image
                Image("furs")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .padding(.top, 40)
                
                // Log-in Text
                Text("Log-in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color.primary) // Adapts to light/dark mode
                
                // Email Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary) // Adapts to light/dark mode
                    
                    TextField("Your email id", text: $viewmodel.email)
                        .padding()
                        .background(Color(UIColor.systemGray6)) // Adapts to light/dark mode
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(Color.primary) // Text color
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                
                // Password Field
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    
                    HStack {
                        SecureField("Password", text: $viewmodel.password)
                            .foregroundColor(Color.primary) // Text color
                        Button(action: {
                            // Action to toggle visibility
                        }) {
                            Image(systemName: "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    
                    if !viewmodel.errormessage.isEmpty {
                        Text(viewmodel.errormessage)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                
                // Forgot Password Button
                Button(action: {
                    //
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
                    Task{ try await viewmodel.login()}
                }) {
                    Text("Login")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue) // Adapt this color as needed
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .padding(.horizontal, 30)
                
                // Sign-up Text
                NavigationLink(destination: RegisterView()) {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.primary) // Adapts to light/dark mode
                        Text("Sign-up")
                            .foregroundColor(.blue) // Stand-out color for sign-up link
                    }
                    .padding(.top, 20)
                }
                        
                            .padding(.top, 20)
                        
                        // Social Media Login Options
                        Text("Or login with")
                            .foregroundColor(Color.primary)
                            .padding(.top, 20)
                        
                        HStack {
                            Button(action: {
                                // Gmail login action
                            }) {
                                Image("google")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .frame(maxHeight: .infinity)
                    .background(Color(UIColor.systemBackground)) // Automatically adapts to light/dark mode
                    .edgesIgnoringSafeArea(.all)
                }
                // .preferredColorScheme(.automatic) // Inherits the system theme
            }
        }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
