//
//  locationSearchCellView.swift
//  FurSpace
//
import SwiftUI

struct locationSearchCellView: View {
   

    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(.blue)
                .font(.system(size: 40))
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text("Downtown")
                    .font(.headline)

                Text("NYC")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Divider()
            }
        
        }.padding(.leading)
        
    }
}

#Preview {
    locationSearchCellView()
}
