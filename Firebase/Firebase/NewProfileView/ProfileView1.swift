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
    
    var body: some View {
        VStack {
            ProfileImageView(imageUrl: viewModel.profileImageUrl)
                .padding(5)
            
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
