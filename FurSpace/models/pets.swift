//
//  pets.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//
import Foundation

// MARK: - Pets Model
struct Pets: Identifiable, Hashable,Codable, Equatable {
    let id: String
    let ownerUID: String
    var petimageurl: String?
    var petname: String
    var activities: String?
    var age: Int
    var breed: String
    let gender: String
    let type: String
    var isPottyTrained: Bool
    var isSpayedNeutered: Bool?
    var isFurnitureAllowed: Bool
    var user : User?
}

// Mock pets data
let mockPets: [Pets] = [
    Pets(
        id: UUID().uuidString, ownerUID: UUID().uuidString,
        petimageurl: "doggy",
        petname: "Buddy",
        activities: "Playing fetch, Running",
        age: 3,
        breed: "Golden Retriever",
        gender: "Male",
        type: "Dog",
        isPottyTrained: true,
        isSpayedNeutered: true,
        isFurnitureAllowed: false
    ),
    Pets(
        id: UUID().uuidString,ownerUID: UUID().uuidString,
        petimageurl: "doggy2",
        petname: "Whiskers",
        activities: "Chasing mice, Sleeping",
        age: 2,
        breed: "Siamese",
        gender: "Female",
        type: "Cat",
        isPottyTrained: true,
        isSpayedNeutered: false,
        isFurnitureAllowed: true
    ),
    Pets(
        id: UUID().uuidString,ownerUID: UUID().uuidString,
        petimageurl: "dogfam",
        petname: "Max",
        activities: "Hiking, Swimming",
        age: 5,
        breed: "Labrador",
        gender: "Male",
        type: "Dog",
        isPottyTrained: true,
        isSpayedNeutered: true,
        isFurnitureAllowed: true
    ),
    Pets(
        id: UUID().uuidString,ownerUID: UUID().uuidString,
        petimageurl: nil,
        petname: "Coco",
        activities: "Flying around the house, Mimicking sounds",
        age: 4,
        breed: "Cockatiel",
        gender: "Female",
        type: "Bird",
        isPottyTrained: false,
        isSpayedNeutered: nil,
        isFurnitureAllowed: false
    )
]
