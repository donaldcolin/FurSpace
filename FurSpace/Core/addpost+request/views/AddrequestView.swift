//
//  AddrequestView.swift
//  FurSpace
//
//  Created by Donald Colin on 28/09/24.
//

import SwiftUI

struct AddRequestView: View {

    @StateObject var viewModel = UploadRequestViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Header with title
            Text("New Dog Walking Request")
                .font(.title2)
                .fontWeight(.bold)

            // Caption input
            VStack(alignment: .leading) {
                Text("Caption:")
                    .font(.headline)
                TextField("Enter a caption", text: $viewModel.caption)
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
                    VStack(alignment: .leading) {
                        Text("From:")
                            .font(.subheadline)
                        DatePicker("", selection: $viewModel.dateFrom, in: Date()..., displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }

                    VStack(alignment: .leading) {
                        Text("To:")
                            .font(.subheadline)
                        DatePicker("", selection: $viewModel.dateTo, in: viewModel.dateFrom..., displayedComponents: [.date])
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
                Task {
                    do {
                        try await viewModel.uploadRequest(caption: viewModel.caption)
                        print("Request uploaded successfully.")
                    } catch {
                        print("Failed to upload request: \(error)")
                    }
                }
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
