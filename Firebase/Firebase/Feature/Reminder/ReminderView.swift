//
//  InfoView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/28/23.
//

import SwiftUI

struct ReminderView: View {
    @State private var selectedDate = Date()
    @State private var scheduledDates: [Date: Bool] = [:]
    let notify = NotificationHandler()
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
           
            VStack {
                //Spacer()
                DatePicker("Pick a date:", selection: $selectedDate, in: Date()... )
                Button("Schedule Reminder") {
                    if scheduledDates[selectedDate] != true {
                        notify.sendNotification(
                            date: selectedDate,
                            type: "date",
                            title: "Limit",
                            body: "Scheduled reminder!");
                            scheduledDates[selectedDate] = true
                    }
                }
            }
            Spacer()
            .padding(.vertical)
            VStack {
            //Displays the score
                ScoreView(score:score)
                badgeView()
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
    }
    func badgeView() -> some View {
            if score.currentScore > 100 {
                return BadgeView(color: .blue, text: "Very Productive", score: score)
            } else if score.currentScore > 30 {
                return BadgeView(color: .orange, text: "Productive", score: score)
            } else if score.currentScore > 15 {
                return BadgeView(color: .green, text: "Doing Good", score: score)
            } else if score.currentScore < 0 {
                return BadgeView(color: .red, text: "Unproductive", score: score)
            } else {
                return BadgeView(color: .gray, text: "Focus", score: score)
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
    let score : Score

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(6)
            .foregroundColor(.white)
            .background(color)
            .clipShape(Capsule())
    }
   
}
