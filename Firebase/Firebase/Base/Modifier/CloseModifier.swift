//
//  CloseModifier.swift
//  FirebaseTest
//
//  Created by swft on 2/8/23.
//

import SwiftUI

struct CloseModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        
        content
            .toolbar{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                
                })
            }
    }
   
    }


extension View{
    
    func applyClose() -> some View{
        self.modifier(CloseModifier())
    }
}
