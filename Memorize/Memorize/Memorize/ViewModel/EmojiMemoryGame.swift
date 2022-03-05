//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
  @Published private var model: MemoryGame<String>
  private var theme: Theme
  
  init(_ theme: Theme) {
    self.model = MemoryGameFactory.createMemoryGame(theme)
    self.theme = theme
  }
  
  var cards: [MemoryGame<String>.Card] {
    self.model.cards
  }
  
  // MARK: - Intents
  func choose(_ card: MemoryGame<String>.Card) {
    self.model.choose(card)
  }
  
  func themeSelected(_ theme: Theme) {
    self.theme = theme
    self.model = MemoryGameFactory.createMemoryGame(theme)
    print("Model = \(self.model)")
  }
}
