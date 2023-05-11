//
//  MathGameView.swift
//  FirebaseTest
//
//  Created by David De La Cruz on 4/14/23.
//

import SwiftUI

/*
 Game Logic:
    - Answer is sum of two random integers each between 0 and 100 (for now)
    - Player will have total of 4 options to choose from
    - Generate 3 random integers based on answer and a chosen distance from answer
        - Within range of (answer - distance) and (answer + distance)
    - Add answer and these 3 random integers into "answerArray"
    - Set choiceArray (what user sees) = shuffled version of "answerArray"
 */

struct MathGameView: View {
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    //@State private var difficulty = 100
    @State private var distanceFromAnswer = 0
    @State private var lowerAnswerBoundary = 0
    @State private var upperAnswerBoundary = 0
    @State private var rounds = 3
    @State private var roundsPassed = 0
    @State public var allRoundsPassed = false
    @State private var intToAdd = 0
    @State private var gameOver = false

    
    var body: some View {
        
        if gameOver {
            GameOverView(restartAction: restartGame)
            
        } else {
            VStack {
                
                // Equation that will be shown on top
                Text("\(firstNumber) + \(secondNumber) = ?")
                    .font(.largeTitle)
                    .bold()
                
                // Top two answer buttons
                HStack{
                    ForEach(0..<2) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label:{
                            MathGameAnswerButton(number: choiceArray[index])
                        }
                    }
                }
                
                // Bottom two answer buttons
                HStack{
                    ForEach(2..<4) { index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label:{
                            MathGameAnswerButton(number: choiceArray[index])
                        }
                    }
                }
                
                // Text on botttom to show how many rounds the user has left
                Text("Rounds Remaining: \(rounds - roundsPassed)")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                
            }.onAppear(perform: generateAnswers)
        }
    }
    // TODO: Added this in class to help set the 'allRoundsPassed' boolean
    func checkRoundsRemaining() {
        if rounds - roundsPassed == 0 {
            allRoundsPassed = true;
            gameOver = true
        }
        else {
            allRoundsPassed = false;
        }
    }
    
    func answerIsCorrect(answer: Int) {
        if answer == correctAnswer {
            roundsPassed += 1
        }
    }
    
    func generateAnswers() {
        firstNumber = Int.random(in: 0...100)
        secondNumber = Int.random(in: 0...100)
        var answerList = [Int]()
        
        correctAnswer = firstNumber + secondNumber
        distanceFromAnswer = 10
        lowerAnswerBoundary = abs(correctAnswer - distanceFromAnswer) // Ensure we don't get negative integer
        upperAnswerBoundary = correctAnswer + distanceFromAnswer
        
        // This adds the other 3 random answers
        for _ in 0...2 {
            
            // This while loop tries to guarantee that each answer choice is unique
            var exitWhileLoop = false
            while(!exitWhileLoop)
            {
                // Select an integer to add between the lower and upper boundaries we defined earlier
                intToAdd = Int.random(in: lowerAnswerBoundary...upperAnswerBoundary)
                
                // If this integer is not in the list and isn't the correct answer, add it
                if !(answerList.contains(intToAdd) && intToAdd != correctAnswer) {
                    exitWhileLoop = true
                }
            }
            answerList.append(intToAdd)
        }
        
        answerList.append(correctAnswer)
        choiceArray = answerList.shuffled()
        checkRoundsRemaining()
    }
    
    func restartGame() {
        correctAnswer = 0
        choiceArray = [0, 1, 2, 3]
        firstNumber = 0
        secondNumber = 0
        distanceFromAnswer = 0
        lowerAnswerBoundary = 0
        upperAnswerBoundary = 0
        rounds = 3
        roundsPassed = 0
        allRoundsPassed = false
        intToAdd = 0
        gameOver = false
        generateAnswers()
    }
    
    
}

struct GameOverView: View {
    let restartAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Game Over!\n\n")
                .font(.largeTitle)
                .bold()
                .padding()
            Button("Restart Game", action: restartAction)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10.0)
        }
    }
}

