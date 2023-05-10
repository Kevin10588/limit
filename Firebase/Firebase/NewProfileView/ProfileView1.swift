//
//  ProfileView1.swift
//  FirebaseTest
//
//  Created by swft on 5/5/23.
import Firebase
import SwiftUI
import FirebaseDatabase

struct ProfileView1: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            ProfileImageView(imageUrl: viewModel.profileImageUrl)
                .padding(5)
            
            ButtonView(title: "App tutorial"){
                showingAlert = true
            }
            .alert("1. Set timer for how long you'd like to be focused.\n\n 2. Productivity Score: add to score by using Timer, To-do list, and Reminders.\n\n 3. Create a To-do list while also setting reminders, so you are notified!\n\n 4. Break Time! Take a break and exxercise your mind by playing a matching card game, or a Math game.\n\n 5. Profile: Personlize your profile by adding a profile picture!", isPresented:$showingAlert) {
                Button("OK", role: .cancel){}
            }
            
                ButtonView(title: "Logout"){
                 
                    sessionService.logout()
                    

            }
            
           
        }
        .padding(30)
        .sheet(isPresented: $viewModel.isShowingImagePicker) {
            ImagePicker(image: $viewModel.profileImage)
        }

    }
}






class ProfileViewModel: ObservableObject {
    
    @Published var profileImage: UIImage?
    @Published var profileImageUrl: String?
    @Published var isShowingImagePicker = false
    @State var image:UIImage?
    
    private let profileImageUploader = ProfileImageUploader()
    private let dbRef = Database.database().reference()
    
    init() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        dbRef.child("users/\(userId)/profileImageUrl").observe(.value) { (snapshot) in
            if let profileImageUrl = snapshot.value as? String {
                self.profileImageUrl = profileImageUrl
            }
        }
    }
    
    func pickProfileImage() {
        isShowingImagePicker = true
    }
   
    
    func uploadProfileImage() {
        guard let profileImage = profileImage else {
            return
        }
        
        profileImageUploader.uploadProfileImage(image: profileImage) { (result) in
            switch result {
            case .success(let downloadURL):
                DispatchQueue.main.async {
                    self.profileImageUrl = downloadURL.absoluteString
                }
            case .failure(let error):
                print("Error uploading profile image: \(error.localizedDescription)")
            }
        }
    }
    
    
    
}


struct ProfileView1_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel()
        return ProfileView1(viewModel: viewModel)
    }
}
