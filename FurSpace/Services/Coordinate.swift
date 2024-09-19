//
//  Coordinate.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import Foundation
import MapKit

// MARK: - Coordinate Model
struct Coordinate: Codable, Hashable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}