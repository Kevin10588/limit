//
//  MathGameView.swift
//  FirebaseTest
//
//  Created by David De La Cruz on 4/14/23.
//

import SwiftUI


//struct MathGameView: View {
//
//}




//------------------------------

/*
struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State var shouldShowImagePicker = false
    @State var image:UIImage?
    @State private var showingAlert = false
    
    
    
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
                VStack {
                    ButtonView(title: "App tutorial") {
                        showingAlert = true
                    }
                    .alert("Set the timer for how long you'd like to procrastinate for. Once the timer is up, non-productive apps will be blocked!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    ButtonView(title: "Logout"){
                            sessionService.logout()
                    }
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
*/
