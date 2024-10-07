//
//  ImageUploader 2.swift
//  FurSpace
//
//  Created by Donald Colin on 04/10/24.
//


import Firebase
import FirebaseStorage
import UIKit

struct PetImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        
        // if the image is lger == small
        //if image is smaller in size == nil (DONT ACCEPT)
        guard let image = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/Petimage/\(filename)")

        do {
            let _ = try await ref.putDataAsync(image)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
