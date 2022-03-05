//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: [Card] = []
  
  private var onlyCardCurrentlyFacingUpIndex: Int?
  
  init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
    for pairIndex in 0..<numberOfPairs {
      let content = createCardContent(pairIndex)
      self.cards.append(Card(content: content))
      self.cards.append(Card(content: content))
    }
    
    self.cards.shuffle()
  }
  
  mutating func choose(_ card: Card) {
    guard let chosenCardIndex = self.cards.firstIndex(of: card),
          !self.cards[chosenCardIndex].isFacedUp,
          !self.cards[chosenCardIndex].isMatched else {
      return
    }
    
    if let currenltySelectedCardIndex = self.onlyCardCurrentlyFacingUpIndex {
      let currenltySelectedCard = self.cards[currenltySelectedCardIndex]
      
      if card.content == currenltySelectedCard.content {
        var newCard1 = Card(card: card)
        newCard1.isMatched = true
        
        self.cards[chosenCardIndex] = newCard1
        
        var newCard2 = Card(card: currenltySelectedCard)
        newCard2.isMatched = true
        
        self.cards[currenltySelectedCardIndex] = newCard2
      }
      
      self.onlyCardCurrentlyFacingUpIndex = nil
    } else {
      for cardIndex in self.cards.indices {
        if !self.cards[cardIndex].isMatched {
          var newCard = Card(card: self.cards[cardIndex])
          newCard.isFacedUp = false
          
          self.cards[cardIndex] = newCard
        }
      }
      
      self.onlyCardCurrentlyFacingUpIndex = chosenCardIndex
    }
    
    var newCard = Card(card: self.cards[chosenCardIndex])
    newCard.isFacedUp = !card.isFacedUp
    
    self.cards[chosenCardIndex] = newCard
  }
  
  struct Card: Identifiable, Equatable {
    static func == (lhs: MemoryGame<CardContent>.Card,
                    rhs: MemoryGame<CardContent>.Card) -> Bool {
      lhs.id == rhs.id
    }
    
    var isFacedUp = false
    var isMatched = false
    var content: CardContent
    var id = UUID()
    
    init(card: Card) {
      self.content = card.content
      self.isMatched = card.isMatched
    }
    
    init(content: CardContent) {
      self.content = content
    }
  }
}
