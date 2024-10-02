//
//  AddrequestView.swift
//  FurSpace
//
//  Created by Donald Colin on 28/09/24.
//

import SwiftUI

struct AddRequestView: View {
    @State private var dateFrom = Date()
    @State private var dateTo = Date()
    @State private var caption = ""

    var body: some View {
        VStack(spacing: 20) {
            // Header with title


            // Caption input
            VStack(alignment: .leading) {
                Text("Caption:")
                    .font(.headline)
                TextField("Enter a caption", text: $caption)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            // Date selection for start and end times
            VStack(alignment: .leading, spacing: 10) {
                Text("Select Dates:")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("From:")
                            .font(.subheadline)
                        DatePicker("", selection: $dateFrom, in: Date()..., displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }

                    HStack {
                        Text("To:")
                            .font(.subheadline)
                        DatePicker("", selection: $dateTo, in: dateFrom..., displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            // Submit button
            Button(action: {
                // Action to submit the request
                print("Request Submitted: From \(dateFrom) to \(dateTo), Caption: \(caption)")
            }) {
                Text("Submit Request")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    AddRequestView()
}
