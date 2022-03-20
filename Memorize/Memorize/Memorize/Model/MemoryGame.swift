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
    get {self.cards.indices
      .filter { self.cards[$0].isFacedUp}.oneAndOnly}
    set {self.cards.indices
      .forEach { self.cards[$0].isFacedUp = ($0 == newValue)} }
  }
  
  init(theme: Theme, createCardContent: (Int) -> CardContent) {
    self.theme = theme
    for pairIndex in 0..<theme.numberOfCards {
      let content = createCardContent(pairIndex)
      self.cards.append(Card(content: content, id: pairIndex * 2))
      self.cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
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
  
  mutating func shuffle() {
    self.cards.shuffle()
  }
  
  struct Card: Identifiable {
    var isFacedUp = false {
      didSet {
        if self.isFacedUp {
          self.startUsingBonusTime()
        } else {
          self.stopUsingBonusTime()
        }
      }
    }
    var isMatched = false {
      didSet {
        self.stopUsingBonusTime()
      }
    }
    var alreadySeen = false
    var content: CardContent
    var id: Int
    
    // can be zero which means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 10
    
    // how long this card has ever been face up
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    // the last time this card was turned face up (and is still face up)
    var lastFaceUpDate: Date?
    // the accumulated  time yhis card has been face up in the past
    // (i.e. not including the current time it`s been face up if it is currently so)
    var pastFaceUpTime: TimeInterval = 0
    
    // how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    // percentage of the bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
      self.isMatched && bonusTimeRemaining > 0
    }
    // whether we are currently face up, unmatched and have not yet used up the bonus window
    var isConsumingBonusTime: Bool {
      self.isFacedUp && !isMatched && bonusTimeRemaining > 0
    }
    
    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    // called when the card goes back face down (or gets matched)
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastFaceUpDate = nil
    }
  }
}
