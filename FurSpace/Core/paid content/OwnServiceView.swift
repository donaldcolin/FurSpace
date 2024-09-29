//
//  OwnServiceView.swift
//  FurSpace
//
//  Created by Donald Colin on 19/09/24.
//


import SwiftUI

// Product struct to represent each product
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

// Sample products data
let sampleProducts = [
    Product(name: "Gps for pets", imageName: "gps"),
    Product(name: "Pet Food 1", imageName: "food1"),
    Product(name: "Pet Food 2", imageName: "food2"),
    Product(name: "Pet Food 3", imageName: "food4"),
    Product(name: "Pet Food 4", imageName: "food3")
]

// ProductView to display each product in a frame
struct ProductView: View {
    let product: Product

    var body: some View {
        VStack {
            Image(product.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            Text(product.name)
                .font(.caption)
                .bold()
        }
        .frame(width: 120, height: 150)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct OwnServiceView: View {
    var body: some View {
        VStack {
            Text("Our products")
                .bold()
                .font(.title)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sampleProducts) { product in
                        ProductView(product: product)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    OwnServiceView()
}
