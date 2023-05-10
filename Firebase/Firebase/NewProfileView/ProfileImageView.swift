//
//  ProfileImageView.swift
//  FirebaseTest
//
//  Created by swft on 5/8/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import URLImage

struct ProfileImageView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    let imageUrl: String?
    @State var image:UIImage?
    @State var UserImage: String =  ""
    private let pasteboard = UIPasteboard.general
    
    
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading,spacing: 10) {
                HStack(spacing: 10){
                    if let imageUrl = imageUrl, let url = URL(string: imageUrl){
                        URLImage(url) { image in
                            image
                                .resizable()
                                .frame(width: 64, height: 64)
                                .scaledToFill()
                                .clipShape(Circle())
                        }
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                    VStack(alignment: .leading,spacing: 5){
                        HStack {
                            //Will show first name
                            Text("\(sessionService.userDetails?.firstName ?? "N/A")")
                            //Will show last name
                            Text("\(sessionService.userDetails?.lastName ?? "N/A")")
                        }
                        //Will show occupation
                        Text("\(sessionService.userDetails?.occupation ?? "N/A")")
                            .navigationTitle("Profile Settings")
                    }
            
                }
                
               .padding(.bottom,50)
                
                VStack(alignment: .leading,spacing:20){
                    TextField("", text: $UserImage)
                        .placeholder(when: UserImage.isEmpty) {
                            Text("Input URL of Image").foregroundColor(.white)
                        }
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                        
                    
                    Button(action: {updateProfileImage()
                    }) {
                        Text("Update Profile Image")
                    }
                }
                Spacer()
                
            }
            
                   .padding(50)
            
        }
    }
    
    
    func paste(){
        if let string = pasteboard.string{
            UserImage = string
        }
    }
    
    
    func updateProfileImage() {
        guard let userId = Auth.auth().currentUser?.uid else {
           
            return
        }

        let ref = Database.database().reference()
        let userRef = ref.child("users").child(userId)

        let newProfileImageUrl = UserImage

        userRef.updateChildValues(["profileImageUrl": newProfileImageUrl]) { (error, _) in
            if let error = error {
                print("Error updating profile image URL: \(error.localizedDescription)")
            } else {
                print("Profile image URL updated successfully")
            }
        }
    }
}


extension View{
    func placeholder<Content: View>( when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
