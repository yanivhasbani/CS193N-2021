//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
  let theme: Theme
  
  private(set) var cards: [Card] = []
  private(set) var score = 0
  
  private var onlyCardCurrentlyFacingUpIndex: Int? {
    get {self.cards.indices.filter { self.cards[$0].isFacedUp}.oneAndOnly}
    set {self.cards.indices.forEach { self.cards[$0].isFacedUp = ($0 == newValue)} }
  }
  
  init(theme: Theme, createCardContent: (Int) -> CardContent) {
    self.theme = theme
    for pairIndex in 0..<theme.numberOfCards {
      let content = createCardContent(pairIndex)
      self.cards.append(Card(content: content, id: pairIndex * 2))
      self.cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
    
    self.cards.shuffle()
  }
  
  mutating func choose(_ card: Card) {
    guard let chosenCardIndex = self.cards.firstIndex(where: {$0.id == card.id}),
          !self.cards[chosenCardIndex].isFacedUp,
          !self.cards[chosenCardIndex].isMatched else {
      return
    }
    
    if let currenltySelectedCardIndex = self.onlyCardCurrentlyFacingUpIndex {
      let currenltySelectedCard = self.cards[currenltySelectedCardIndex]
      self.cards[chosenCardIndex].isFacedUp = true
      
      if card.content == currenltySelectedCard.content {
        self.cards[chosenCardIndex].isMatched = true
        self.cards[currenltySelectedCardIndex].isMatched = true
        self.score += 2
      } else {
        if self.cards[chosenCardIndex].alreadySeen {
          self.score -= 1
        }
        self.cards[chosenCardIndex].alreadySeen = true
        
        if self.cards[currenltySelectedCardIndex].alreadySeen {
          self.score -= 1
        }
        self.cards[currenltySelectedCardIndex].alreadySeen = true
      }
    } else {
      self.onlyCardCurrentlyFacingUpIndex = chosenCardIndex
    }
  }
  
  struct Card: Identifiable {
    var isFacedUp = false
    var isMatched = false
    var alreadySeen = false
    var content: CardContent
    var id: Int
  }
}
