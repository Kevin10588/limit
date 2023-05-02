//
//  EmojiMemoryGame.swift
//  Memorizer
//
//  Created by Anthony on 3/19/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀",
                  "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"] // static makes a variable global but it changes it's name to EmojiMemoryGame.emojis
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) {pairIndex in
                emojis[pairIndex] // Full name or emojis is EmojiMemoryGame.emojis
            }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<Card> {
        return model.cards
    }
    
    
    // MARK: - Intent(s)
        
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
