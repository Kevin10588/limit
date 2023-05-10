//
//  LimitTabView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/14/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

struct ProfileView: View {
    
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State var shouldShowImagePicker = false
    @State var image:UIImage?
    @State var StatusMessage = ""
    
    @State private var showingAlert = false
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 400){
                
                HStack{
                    
                    Button(action: {
                        shouldShowImagePicker.toggle()
                        persistImageToStorage()
                        
                    }) {
                        VStack{
                            
                            if let image = self.image{
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .scaledToFill()
                                    .cornerRadius(64)
                                
                                
                            }else{
                                
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 55, alignment: .center)
                                    .foregroundColor(Color("modeColor"))
                            }}}
                    
                    VStack(alignment: .leading,
                           spacing: 16) {
                        
                        
                        
                        HStack {
                            //Will show first name
                            Text("\(sessionService.userDetails?.firstName ?? "N/A")")
                            //Will show last name
                            Text("\(sessionService.userDetails?.lastName ?? "N/A")")
                        }
                        //Will show occupation
                        Text("\(sessionService.userDetails?.occupation ?? "N/A")")
                        
                        
                        
                    }
                    
                    
                }
                
                
                ButtonView(title: "Logout"){
                    persistImageToStorage()
                    sessionService.logout()
                    
                    
                }
                
            }
                   .navigationTitle("Profile Settings")
            
                   .fullScreenCover(isPresented: $shouldShowImagePicker){
                       ImagePicker(image: $image)
                   }
            
            
        }
        
        .padding(.horizontal, 16)
        
    }
    private func handleAction(){
        addPic()
    }
    private func addPic(){
        self.persistImageToStorage()
    }
    
    private func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.StatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.StatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.StatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString ?? Image(systemName: "person.circle"))
                
                guard let url = url else{ return}
                
            }
        }
    }
    
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImpl())
    }
}
