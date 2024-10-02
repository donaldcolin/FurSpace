import SwiftUI

struct DoctorRequestView: View {
    @State private var selectedDate = "24 Sunday"
    @State private var selectedTime = 8.0

    var body: some View {
        VStack {
            // Top Profile Info
            VStack {
                Image("doctor_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top)
                
                Text("Sarah Johnson")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("MBBS, MD\nPediatric Specialist")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.6")
                        .font(.subheadline)
                }
                .padding(.top, 4)
            }
            
            // Action Buttons
            HStack(spacing: 20) {
                Button(action: { /* Details action */ }) {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
                Button(action: { /* Call action */ }) {
                    Image(systemName: "phone.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                Button(action: { /* Message action */ }) {
                    Image(systemName: "message.fill")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                }
                
            }
            .padding(.vertical)
            
            // Info Cards
            HStack(spacing: 20) {
                VStack {
                    Text("8 Years")
                        .font(.headline)
                    Text("Experience")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("3.5k+")
                        .font(.headline)
                    Text("Patients")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("2.8k+")
                        .font(.headline)
                    Text("Reviews")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)
            
            // Date Picker
            HStack {
                ForEach(["22", "23", "24", "25"], id: \.self) { date in
                    Button(action: {
                        self.selectedDate = date
                    }) {
                        Text(date)
                            .padding()
                            .background(self.selectedDate == date ? Color.blue : Color.clear)
                            .cornerRadius(10)
                            .foregroundColor(self.selectedDate == date ? .white : .black)
                    }
                }
            }
            .padding(.horizontal)
            
            // Time Picker (Slider)
            VStack {
                Text("Select Time")
                    .font(.headline)
                    .padding(.top)
                
                Slider(value: $selectedTime, in: 7.0...21.0, step: 0.5)
                    .accentColor(.blue)
                    .padding(.horizontal)
                
                Text("\(String(format: "%.2f", selectedTime))")
                    .font(.title)
            }
            
            // Book Button
            Button(action: { /* Book session action */ }) {
                Text("Book Session")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
    }
}

struct DoctorBookingView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorRequestView()
    }
}
