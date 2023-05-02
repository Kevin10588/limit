//
//  Score.swift
//  FirebaseTest
//
//  Created by Luis Montalvo on 4/24/23.
//

import Foundation
import SwiftUI

class Score: ObservableObject {
    // current score will be store even if the app is closed
    @Published var currentScore = UserDefaults.standard.integer(forKey: "score") {
        didSet {
            UserDefaults.standard.set(currentScore, forKey: "score")
            self.objectWillChange.send()
        }
    }
    // functions to add or remove from score
    func addScore() {
        currentScore += 10
    }
    
    func penalize() {
        currentScore -= 5
    }
}

struct ScoreView: View {
    @ObservedObject var score: Score = Score()
    
    var body: some View {
        Text("Productivity Score: \(score.currentScore)")
            .font(.title)
    }
    
    func badgeView() -> some View {
            if score.currentScore > 100 {
                return BadgeView(color: .blue, text: "Productive", score: score)
            } else if score.currentScore > 30 {
                return BadgeView(color: .orange, text: "Focused", score: score)
            } else if score.currentScore > 15 {
                return BadgeView(color: .green, text: "Doing Good", score: score)
            } else if score.currentScore < 0 {
                return BadgeView(color: .red, text: "Unproductive", score: score)
            } else {
                return BadgeView(color: .gray, text: "Okay", score: score)
            }
        }
}
    
