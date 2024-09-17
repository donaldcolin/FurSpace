import SwiftUI

struct PostorRequestSelectionView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: AddRequestView()) {
                            CustomRowView(buttonTitle: "Add a Post", backgroundColor: .orange)
                        }
                        
                        NavigationLink(destination: AddDogBoardingRequestView()) {
                            CustomRowView(buttonTitle: "Add a Request for Dog Boarding", backgroundColor: .green)
                        }
                        
                        NavigationLink(destination: AddDogWalkingRequestView()) {
                            CustomRowView(buttonTitle: "Add a Request for Dog Walking", backgroundColor: .blue)
                        }
                        
                        NavigationLink(destination: DoctorRequestView()) {
                            CustomRowView(buttonTitle: "Get a Consult from a Vet", backgroundColor: .purple)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Select an Option")
        }
    }
}

struct CustomRowView: View {
    var buttonTitle: String
    var backgroundColor: Color

    var body: some View {
        HStack {
            Text(buttonTitle)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 20)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .padding(.trailing, 20)
        }
        .frame(width: 250, height: 500) // Larger button size
        .background(backgroundColor)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

// Sample destination views
struct AddPostView: View {
    var body: some View {
        Text("Add a Post View")
    }
}

struct AddDogBoardingRequestView: View {
    var body: some View {
        Text("Add a Request for Dog Boarding View")
    }
}

struct AddDogWalkingRequestView: View {
    var body: some View {
        Text("Add a Request for Dog Walking View")
    }
}

struct VetConsultView: View {
    var body: some View {
        Text("Get a Consult for a Vet View")
    }
}

#Preview {
    PostorRequestSelectionView()
}
