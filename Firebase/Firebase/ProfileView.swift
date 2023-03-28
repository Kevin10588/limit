//
//  LimitTabView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/14/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State var shouldShowImagePicker = false
    @State var image:UIImage?
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 400){
                HStack{
                    
                    Button(action: {
                        shouldShowImagePicker.toggle()
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
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
            ProfileView()
                .environmentObject(SessionServiceImpl())
    }
}
