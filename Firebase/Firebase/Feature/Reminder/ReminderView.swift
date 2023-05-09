//
//  InfoView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/28/23.
//

import SwiftUI

struct ReminderView: View {

    // creating the score instance
    @ObservedObject var score = Score()

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
            .padding(.bottom)
            Spacer()
            
            Spacer()
            VStack {
                //Displays the score
                badgeView()
                ScoreView(score:score)
            }
            .frame(height: 550, alignment: .center)
            Spacer()
            .padding(.vertical)
                /// used for testing to add and remove from the score
                VStack{
                    Button("Add Score", action: {
                        score.addScore()
                    })
                    Button("Penalize", action: {
                        score.penalize()
                    })
                }
            }
        }
    func badgeView() -> some View {
        let bronzeColor = Color(hue: 0.08, saturation: 0.66, brightness: 0.66)
        let silverColor = Color(hue: 0.55, saturation: 0.01, brightness: 0.80)
        let goldColor = Color(hue: 0.14, saturation: 0.84, brightness: 0.90)
            if score.currentScore > 100 {
                return BadgeView(color: goldColor, text: "Very Productive",imageName: "Gold" , score: score)
            } else if score.currentScore > 30 {
                return BadgeView(color: silverColor, text: "Productive", imageName: "Silver", score: score)
            } else if score.currentScore > 15 {
                return BadgeView(color: silverColor, text: "Doing Good", imageName: "Silver" , score: score)
            } else if score.currentScore < 0 {
                return BadgeView(color: .red, text: "Unproductive", imageName: "logo" , score: score)
            } else {
                return BadgeView(color: bronzeColor, text: "Focus!", imageName: "Bronze" , score: score)
            }
        }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(score: Score())
    }
}



struct BadgeView: View {
    let color: Color
    let text: String
    let imageName:String
    let score : Score

    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .cornerRadius(15)
            
            }
        Text(text)
        .font(.caption)
        .padding(6)
        .foregroundColor(.white)
        .background(color)
        .clipShape(Capsule())

    }
   
}
