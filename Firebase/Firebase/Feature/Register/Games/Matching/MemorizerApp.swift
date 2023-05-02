//
//  MemorizerApp.swift
//  Memorizer
//
//  Created by Anthony on 3/16/23.
//

import SwiftUI

struct MemorizerApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
