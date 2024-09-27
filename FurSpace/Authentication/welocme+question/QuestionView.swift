import SwiftUI

struct PetQuestionnaireView: View {
    @StateObject private var viewModel = PetQuestionnaireViewModel()
    @State private var isImagePickerPresented: Bool = false
    let petTypes = ["Dog", "Cat", "Bird", "Others"]
    let genders = ["Male", "Female"]
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Pet Information Section
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Pet Information")
                                    .font(.title2)
                                    .bold()
                                
                                // Pet Image Picker
//                                VStack {
//                                    if let petImage = viewModel.petImage {
//                                        petImage
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 100, height: 100)
//                                            .clipShape(Circle())
//                                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
//                                            .shadow(radius: 10)
//                                    } else {
//                                        Button(action: {
//                                            isImagePickerPresented = true
//                                        }) {
//                                            Image(systemName: "pawprint")
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 100, height: 100)
//                                                .foregroundColor(.blue)
//                                        }
//                                    }
//                                }
//                                .padding(.bottom, 20)
//                                .sheet(isPresented: $isImagePickerPresented) {
//                                    ImagePicker(image: $viewModel.petImage)
//                                }
                                
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
                                
                                TextField("Pet Name", text: $viewModel.petName)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(8)
                                
                                TextField("Pet Age (in years)", text: $viewModel.petAge)
                                    .keyboardType(.numberPad)
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
                                
                                Toggle(isOn: $viewModel.isFurnitureAllowed) {
                                    Text("Is furniture allowed?")
                                }
                                .padding(.vertical)
                                
                                Toggle(isOn: $viewModel.isPottyTrained) {
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
                        }
                    }
                    .background(Color(.systemGroupedBackground))
                    
                    // Validation Error Message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom)
                    }
                    
                    // Continue Button
                    NavigationLink {
                        WelcomeView()
                               } label: {
                                   Text("Sign up")
                                       .font(.subheadline)
                                       .fontWeight(.bold)
                                       .foregroundColor(Color.white)
                                       .frame(width: 360,height: 44)
                                       .background(Color(.systemBlue))
                                   .cornerRadius(10)}
                    .padding(.bottom, 20)
                }
                .navigationTitle("Pet Questionnaire")
            }
        }
    }
                           }

struct PetQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        PetQuestionnaireView()
    }
}
