//
//  PleaseVIew.swift
//  FurSpace
//
//  Created by Donald Colin on 17/09/24.
//

import SwiftUI

struct PleaseVIew: View {
    var body: some View {
        VStack{
            Image("fur")
                .resizable()
                .scaledToFit()
                .frame( height: 300)
                .padding(.top, 0)
            Spacer()
Text("Greeting sfrom FurSpace")
            Spacer()
            
            Text("Hello **donald colin** please spare us two minutues to enter your details")
            Spacer()
            Button(action: {
                // Handle continue action here
            }) {
                Text("Continue")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
        }.padding()
    }
        
    }
    


#Preview {
    PleaseVIew()
}
