//
//  PetQuestionnaireViewModel.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import SwiftUI

class PetQuestionnaireViewModel: ObservableObject {
    // Form Fields
    @Published var petType: String = "Dog"
    @Published var otherPetType: String = ""
    @Published var breed: String = ""
    @Published var isFurnitureAllowed: Bool = false
    @Published var isPottyTrained: Bool = false
    @Published var isVaccinated: Bool = false
    @Published var petName: String = ""
    @Published var activities: String = ""
    @Published var petAge: String = ""
    @Published var gender: String = "Male"
    @Published var isSpayedNeutered: Bool = false
    @Published var petImage: Image? = nil
    
    // Validation Errors
    @Published var errorMessage: String = ""
    
    // Validation Logic
    func validate() -> Bool {
        // Pet name validation
        guard !petName.isEmpty else {
            errorMessage = "Please enter the pet's name."
            return false
        }
        
        // Pet type-specific validations
        if petType == "Others" && otherPetType.isEmpty {
            errorMessage = "Please specify the type of your pet."
            return false
        }
        
        // Breed validation
        guard !breed.isEmpty else {
            errorMessage = "Please enter the breed of your pet."
            return false
        }
        
        // Age validation
        guard !petAge.isEmpty, Int(petAge) != nil else {
            errorMessage = "Please enter a valid pet age."
            return false
        }
        
        // If all validations pass
        errorMessage = ""
        return true
    }
}