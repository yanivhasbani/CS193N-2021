//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  
  @Published private var model: MemoryGame<String>
  
  init(_ theme: Theme) {
    self.model = MemoryGameFactory.createMemoryGame(theme)
  }
  
  var cards: [Card] {
    self.model.cards
  }
  
  var cardColor: Gradient {
    self.model.theme.cardColor
  }
  
  var name: String {
    self.model.theme.name
  }
  
  var score: Int {
    self.model.score
  }
  
  // MARK: - Intents
  func choose(_ card: Card) {
    self.model.choose(card)
  }
  
  func newGame() {
    guard let themeSelected = Theme(rawValue: Int(arc4random()) % Theme.allCases.count) else {
      return
    }
    
    self.model = MemoryGameFactory.createMemoryGame(themeSelected)
  }
}
