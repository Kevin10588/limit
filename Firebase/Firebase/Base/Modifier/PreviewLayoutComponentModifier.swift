//
//  PreviewLayoutComponentModifier.swift
//  FirebaseTest
//
//  Created by swft on 2/7/23.
//

import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier{
    
    let name: String
    
    func body(content: Content) -> some View{
        
        content
        .previewLayout(.sizeThatFits)
        .previewDisplayName(name)
        .padding()
        
        
        
        
    }
}

extension View{
    
    func preview(with name: String) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name))
    }
}
