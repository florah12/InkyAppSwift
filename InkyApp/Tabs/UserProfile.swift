import SwiftUI

struct UserProfile: View {
    @State private var biography: String = UserDefaults.standard.string(forKey: "userBiography") ?? "Add your biography here" // Load saved bio or default text
    @State private var isEditingBio = false // Tracks if the user is editing the bio

    let gradient = Gradient(colors: [.inkblue, .inkwhite]) // Adjust colors as needed

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                VStack {
                    // Profile Picture
                    Image("demoprofilepic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .clipped()
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(.top, 52)
                    
                    // Name and Username
                    Text("Estella Bella")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text("@Its.Estella")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .padding(.top, 2)
                    
                    // Creations and Followers
                    HStack {
                        VStack {
                            Text("3")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text("Creations")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        
                        Spacer().frame(width: 40)
                        
                        VStack {
                            Text("101.7k")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text("Followers")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 20)
                }
                Spacer()
            }
            .padding()
            
            // Editable Biography Section
            VStack(alignment: .leading) {
                Text("Biography")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)

                TextEditor(text: $biography)
                    .font(.body)
                    .foregroundColor(biography == "Add your biography here" && !isEditingBio ? .gray : .black) // Show placeholder text in gray
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(height: 200) // Adjust height
                    .shadow(radius: 5)
                    .onTapGesture {
                        if biography == "Add your biography here" {
                            biography = "" // Clear placeholder text
                        }
                        isEditingBio = true
                    }
                    .onChange(of: biography) { newValue in
                        if newValue != "Add your biography here" && !newValue.isEmpty {
                            UserDefaults.standard.set(newValue, forKey: "userBiography") // Save to UserDefaults
                        }
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all))
        .onTapGesture {
            if biography.isEmpty {
                biography = "Add your biography here" // Reset placeholder if empty
            }
            isEditingBio = false
        }
    }
}

#Preview {
    UserProfile()
}
