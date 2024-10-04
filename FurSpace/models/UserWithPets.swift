//
//  UserWithPets.swift
//  FurSpace
//
//  Created by Donald Colin on 04/10/24.
//


import Foundation

struct UserWithPets: Identifiable {
    var id: ObjectIdentifier
    let user: User
    var pets: [Pets]
}
