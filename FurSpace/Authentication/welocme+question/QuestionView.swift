import SwiftUI

struct PetQuestionnaireView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @State private var isImagePickerPresented: Bool = false
    let petTypes = ["Dog", "Cat", "Bird", "Others"]
    let genders = ["Male", "Female"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Pet Information Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pet Information")
                            .font(.title2)
                            .bold()
                        
                        // Commented out the image picker as per your requirement
                        // Picker for Pet Type
                        Picker("What pet do you own?", selection: $viewModel.petType) {
                            ForEach(petTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical)
                        
                        if viewModel.petType == "Others" {
                            TextField("Specify the pet", text: $viewModel.otherPetType)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                        }
                        
                        TextField("Breed of Pet", text: $viewModel.breed)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                        
                        TextField("Pet Name", text: $viewModel.petname)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                        
                        TextField("Pet Age (in years)", text: $viewModel.petname)
                            //.keyboardType(.numberPad)  // Ensure user only enters numbers
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    // Additional Details Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Additional Details")
                            .font(.title2)
                            .bold()
                        
                        Toggle(isOn: $viewModel.isfurniture) {
                            Text("Is furniture allowed?")
                        }
                        .padding(.vertical)
                        
                        Toggle(isOn: $viewModel.ispotty) {
                            Text("Is the pet potty trained?")
                        }
                        .padding(.vertical)
                        
                        Toggle(isOn: $viewModel.isVaccinated) {
                            Text("Is the pet vaccinated?")
                        }
                        .padding(.vertical)
                        
                        Toggle(isOn: $viewModel.isSpayedNeutered) {
                            Text("Is the pet spayed/neutered?")
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    
                    // Pet Activities Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pet Activities")
                            .font(.title2)
                            .bold()
                        
                        TextField("Activities your pet enjoys", text: $viewModel.activities)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    // Pet Gender Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pet Gender")
                            .font(.title2)
                            .bold()
                        
                        Picker("Gender of Pet", selection: $viewModel.gender) {
                            ForEach(genders, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical)
                    }
                    .padding()
                    
                    // Validation Error Message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom)
                    }
                    
                    // Continue Button
                    NavigationLink {
                        WelcomeView()  // Change this destination according to your app's flow
                    } label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Pet Questionnaire")
        }
    }
}

struct PetQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        PetQuestionnaireView()
    }
}
