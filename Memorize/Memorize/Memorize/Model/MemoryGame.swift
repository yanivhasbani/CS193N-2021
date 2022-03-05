//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

struct MemoryGame<CardContent> {
  private(set) var cards: [Card] = []
  
  init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
    for pairIndex in 0..<numberOfPairs {
      let content = createCardContent(pairIndex)
      self.cards.append(Card(content: content))
      self.cards.append(Card(content: content))
    }
  }
  
  func choose(_ card: Card) {
    
  }
  
  struct Card {
    var isFacedUp = false
    var isMatched = false
    var content: CardContent
  }
}
