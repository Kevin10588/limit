//
//  GamesView.swift
//  FirebaseTest
//
//  Created by Anthony on 4/29/23.
//

import SwiftUI

struct GameView: View {
    @State private var isShowingGameView = false
    @State private var selectedGame: String?
    
    var body: some View {
        NavigationView {
            VStack {
                    Group {
                        // Button that triggers the navigation to the game view
                        Button (action: {
                            selectedGame = "EmojiMemoryGame()"
                            isShowingGameView = true
                        }, label: {
                            Text("Matching Game")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxHeight: .infinity)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                                .shadow(color: Color.blue.opacity(0.3),
                                        radius: 10, x: 0.0, y: 10)
                                .padding(50)
                        })
                        
                        Button(action: {
                            selectedGame = "MathGame()"
                            isShowingGameView = true
                        }, label: {
                            Text("Math Game")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxHeight: .infinity)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                                .shadow(color: Color.blue.opacity(0.3),
                                        radius: 10, x: 0.0, y: 10)
                                .padding(50)
                        })
                        
                        
                        if selectedGame == "EmojiMemoryGame()" {
                            NavigationLink(
                                destination: EmojiMemoryGameView(game: EmojiMemoryGame()),
                                isActive: $isShowingGameView,
                                label: { EmptyView() }
                            )
//######################## CHANGE THIS ELSE IF TO IMPLEMENT THE MATH GAME ###################################################
                        } else if selectedGame == "MathGame()" {
                            NavigationLink(
                                destination: MathGameView(),
                                isActive: $isShowingGameView,
                                label: { EmptyView() }
                            )
                        }
                    }
                    .navigationTitle("Games")
                
            }
        }
    }
}

