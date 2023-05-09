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
            VStack(alignment: .leading,
                   spacing:5) {
                if let imageUrl = imageUrl, let url = URL(string: imageUrl){
                    URLImage(url) { image in
                        image
                            .resizable()
                            .frame(width: 128, height: 128)
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .scaledToFit()
                        .clipShape(Circle())
                }
                
                HStack {
                    //Will show first name
                    Text("\(sessionService.userDetails?.firstName ?? "N/A")")
                    //Will show last name
                    Text("\(sessionService.userDetails?.lastName ?? "N/A")")
                }
                //Will show occupation
                Text("\(sessionService.userDetails?.occupation ?? "N/A")")
                    .navigationTitle("Profile Settings")
                
                VStack(alignment: .leading,
                       spacing:5){
                    
                    TextField("Type Something Here", text: $UserImage)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {updateProfileImage()
                    }) {
                        Text("Update Profile Image")
                    }
                }
                
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


