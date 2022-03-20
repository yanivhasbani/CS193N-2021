//
//  Game.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct Game {  
  private(set) var cards: [Card] = {
    Game.generateCards()
  }()
  
  private let numberOfCardVisible: Int
  
  private var selectedCardIndicies: [Int] {
    self.cards.indices.filter {
      self.cards[$0].isSelected
    }
  }
  
  init(_ cards: [Card] = Game.generateCards(),
       _ numberOfCardVisible: Int = Constants.startingNumberOfCards) {
    self.numberOfCardVisible = numberOfCardVisible
  }
  
  mutating func choose(_ card: Card) {
    guard let cardIndex = self.cards.firstIndex(where:{ $0.id == card.id }) else {
      return
    }
    
    self.cards[cardIndex].isSelected.toggle()
    
    let numberOfSelectedCards = self.selectedCardIndicies.count
    if numberOfSelectedCards == Constants.numberOfCardsToMatch {
      self.threeCardsSelected()
    }
  }
  
  mutating func draw(_ numberOfCards: Int) {
    var drawnCardIndices: [Int] = []
    repeat {
      guard let cardIndex = self.cards.firstIndex(where: { !$0.isPlaying }) else {
        break
      }
      
      self.cards[cardIndex].isPlaying = true
      drawnCardIndices.append(cardIndex)
    } while drawnCardIndices.count < numberOfCards
  }
  
  private mutating func threeCardsSelected() {
    let selectedCardIndicies = self.selectedCardIndicies
    if self.selectedCardsMakeSet(selectedCardIndicies) {
      for selectedCardIndex in selectedCardIndicies {
        self.cards[selectedCardIndex].isMatched = true
        self.cards[selectedCardIndex].isSelected.toggle()
      }
    } else {
      for selectedCardIndex in selectedCardIndicies {
        self.cards[selectedCardIndex].isSelected.toggle()
      }
    }
  }
  
  private func selectedCardsMakeSet(_ selectedCardIndicies: [Int]) -> Bool {
    var fills: Set<Card.Fill> = []
    var shapes: Set<Card.Shape> = []
    var color: Set<Color> = []
    var numberOfElements: Set<Int> = []
    
    for selectedCardIndex in selectedCardIndicies {
      fills.insert(self.cards[selectedCardIndex].fill)
      shapes.insert(self.cards[selectedCardIndex].shape)
      color.insert(self.cards[selectedCardIndex].color)
      numberOfElements.insert(self.cards[selectedCardIndex].numberOfItems)
    }
    
    return (fills.count != 2 && shapes.count != 2 &&
            color.count != 2 && numberOfElements.count != 2)
  }
  
  static private func generateCards() -> [Card] {
    var cards: [Card] = []
    
    for fillType in Card.Fill.allCases {
      for shape in Card.Shape.allCases {
        for numberOfElementInCard in 1..<Constants.maximumNumberOfElements + 1 {
          for color in Constants.possibleColors {
            let card = Card(color: color, shape: shape,
                            fill: fillType, numberOfItems: numberOfElementInCard)
            cards.append(card)
          }
        }
      }
    }
    
    return cards
  }
  
  private struct Constants {
    static let maximumNumberOfElements = 3
    static let startingNumberOfCards = 12
    static let possibleColors: [Color] = [.red, .blue, .orange]
    static let numberOfCardsToMatch = 3
  }
}


