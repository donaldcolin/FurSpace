//
//  locationShowview.swift
//  FurSpace
//
//  Created by Donald Colin on 16/09/24.
//

import SwiftUI

struct locationShowview: View {
    @State var userlocation = ""
    var body: some View {
        
        VStack {
                    TextField("Search user location", text: $userlocation)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6)) // Light background color
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1) // Border around TextField
                        )
                        .padding([.leading, .trailing], 16)
            Divider()
                }
                .padding()
        ScrollView{
            VStack{
                ForEach(1...50 ,id: \.self){ _ in
                    locationSearchCellView()
                }
            }
        }
    }
}

#Preview {
    locationShowview()
}
