import SwiftUI

struct PetQuestionnaireView: View {
    @State private var petType: String = "Dog"
    @State private var otherPetType: String = ""
    @State private var breed: String = ""
    @State private var isFurnitureAllowed: Bool = false
    @State private var isPottyTrained: Bool = false
    @State private var isVaccinated: Bool = false
    @State private var petName: String = ""
    @State private var activities: String = ""
    @State private var petAge: String = ""
    @State private var gender: String = "Male"
    @State private var isSpayedNeutered: Bool = false
    @State private var petImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    
    let petTypes = ["Dog", "Cat", "Bird", "Others"]
    let genders = ["Male", "Female"]
    
    var body: some View {
        VStack {
            NavigationStack{
                ScrollView {
                    VStack(spacing: 20) {
                        // Pet Information Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Pet Information")
                                .font(.title2)
                                .bold()
                            
                            // Pet Image Picker
                            VStack {
                                if let petImage = petImage {
                                    petImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                        .shadow(radius: 10)
                                } else {
                                    Button(action: {
                                        isImagePickerPresented = true
                                    }) {
                                        Image(systemName: "pawprint")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                            .sheet(isPresented: $isImagePickerPresented) {
                                ImagePicker(image: $petImage)
                            }
                            
                            Picker("What pet do you own?", selection: $petType) {
                                ForEach(petTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical)
                            
                            if petType == "Others" {
                                TextField("Specify the pet", text: $otherPetType)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(8)
                            }
                            
                            TextField("Breed of Pet", text: $breed)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                            
                            TextField("Pet Name", text: $petName)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                            
                            TextField("Pet Age (in years)", text: $petAge)
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
                            
                            Toggle(isOn: $isFurnitureAllowed) {
                                Text("Is furniture allowed?")
                            }
                            .padding(.vertical)
                            
                            Toggle(isOn: $isPottyTrained) {
                                Text("Is the pet potty trained?")
                            }
                            .padding(.vertical)
                            
                            Toggle(isOn: $isVaccinated) {
                                Text("Is the pet vaccinated?")
                            }
                            .padding(.vertical)
                            
                            Toggle(isOn: $isSpayedNeutered) {
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
                            
                            TextField("Activities your pet enjoys", text: $activities)
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
                            
                            Picker("Gender of Pet", selection: $gender) {
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
                
                // Continue Button
                NavigationLink(destination: WelcomeView()) {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Pet Questionnaire")
        }
    }
}

struct PetQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        PetQuestionnaireView()
    }
}
