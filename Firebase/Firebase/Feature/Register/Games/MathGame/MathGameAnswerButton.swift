//
//  MathGameAnswerButton.swift
//  FirebaseTest
//
//  Created by David De La Cruz on 4/15/23.
//

import SwiftUI

struct MathGameAnswerButton: View {
    var number : Int
    
    var body: some View {
        Text("\(number)")
            .frame(width: 80, height: 60)
            .font(.system(size: 40 , weight: .bold))
            .foregroundColor(Color.white)
            .background(Color.blue)
            .padding()
    }
}

struct MathGameAnswerButon_Previews: PreviewProvider {
    static var previews: some View {
        MathGameAnswerButton(number: 100)
    }
}
