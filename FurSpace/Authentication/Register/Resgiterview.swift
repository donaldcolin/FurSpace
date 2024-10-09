import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewmodel: RegisterViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Illustration Image
                Image("fur")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .padding(.top, 50)
                
                // Sign-up Text
                Text("Sign-upbjkbbbkjbkjbkbkbjkbkjbkjbkjbjkkbkjbkjbjkbkjbkjbkjbkjbkjbkjbkjbkbkjbkjbkjbkjbkbkbkbkbkbkbkb")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary) // Adapts to light/dark mode
                
                // Name Field
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    
                    TextField("Your name", text: $viewmodel.fullname)
                        .padding()
                        .background(Color(UIColor.systemGray6)) // Dynamic field background
                        .cornerRadius(10)
                        .autocapitalization(.words)
                        .foregroundColor(Color.primary) // Text color adapts to mode
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                
                // Email Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                    
                    TextField("Your email id", text: $viewmodel.email)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(Color.primary)
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
                            .foregroundColor(Color.primary)
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
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                
                // Confirm Password Field
//                VStack(alignment: .leading) {
//                    Text("Confirm Password")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.primary)
//
//                    HStack {
//                        SecureField("Confirm Password", text: $viewmodel.confirmPassword)
//                            .foregroundColor(Color.primary)
//                        Button(action: {
//                            // Action to toggle visibility
//                        }) {
//                            Image(systemName: "eye.fill")
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    .padding()
//                    .background(Color(UIColor.systemGray6))
//                    .cornerRadius(10)
//                }
//                .padding(.top, 10)
//                .padding(.horizontal, 30)
                
                // Sign-up Button
                NavigationLink(destination: PleaseVIew()) {
                    Text("Sign-up")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue) // Custom button color
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                .padding(.horizontal, 30)
                
                // Login Option
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(Color.primary)
                    NavigationLink(destination: LoginView()) {
                        Text("Log-in")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .background(Color(UIColor.systemBackground)) // Adapts to light/dark mode
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
