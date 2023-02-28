//
//  InfoView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/28/23.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20, alignment: .center)
                    .foregroundColor(Color.accentColor)
                    .padding(.top)
                Text("Limit")
                    .foregroundColor(Color.accentColor)
                    .font(.headline)
                    .padding(.top)
            }
            
            HStack {
                Text("App Usage")
                    .font(.title2)
                //.bold()
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                    .padding(.leading)
                Spacer()
            }
            
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
