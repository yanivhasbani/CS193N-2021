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
  
  private(set) var drawnedCards: [Card] = []
  
  private let numberOfCardVisible: Int
  private var numberOfCardsNotYetPlayed: Int {
    self.cards.count
  }
  
  private var cardSelectedIndicies: [Int] {
    self.drawnedCards.indices.filter {
      self.drawnedCards[$0].isSelected
    }
  }
  
  init(_ cards: [Card] = Game.generateCards(),
       _ numberOfCardVisible: Int = Constants.numberOfCardVisible) {
    self.numberOfCardVisible = numberOfCardVisible
    self.drawnedCards = self.drawCards(self.numberOfCardVisible)
  }
  
  mutating func choose(_ card: Card) {
    guard let cardIndex = self.drawnedCards.firstIndex(where:{ $0.id == card.id }) else {
      return
    }
    
    self.drawnedCards[cardIndex].isSelected.toggle()
    let cardSelectedIndicies = self.cardSelectedIndicies
    print("Number of selected = \(cardSelectedIndicies.count)")
    
    guard cardSelectedIndicies.count == Constants.numberOfCardsToMatch else {
      return
    }
    
    if self.selectedCardsMakeSet(cardSelectedIndicies) {
      var drawnCardsToMutate = self.drawnedCards
      for selectedCardIndex in cardSelectedIndicies {
        drawnCardsToMutate[selectedCardIndex].isMatched = true
        drawnCardsToMutate[selectedCardIndex].isSelected.toggle()
      }
      
      if self.drawnedCards.filter({ !$0.isMatched }).count < Constants.numberOfCardVisible {
        let drawnCards = self.drawCards(Constants.numberOfCardsToMatch)
        drawnCardsToMutate.append(contentsOf: drawnCards)
      }
      
      self.drawnedCards = drawnCardsToMutate
    } else {
      for selectedCardIndex in cardSelectedIndicies {
        self.drawnedCards[selectedCardIndex].isSelected.toggle()
      }
    }
  }
  
  mutating func draw() {
    let drawnCards = self.drawCards(Constants.numberOfCardsToMatch)
    self.drawnedCards.append(contentsOf: drawnCards)
  }
  
  private func selectedCardsMakeSet(_ selectedCardIndicies: [Int]) -> Bool {
    var fills: Set<Card.Fill> = []
    var shapes: Set<Card.Shape> = []
    var color: Set<Color> = []
    var numberOfElements: Set<Int> = []
    
    for selectedCardIndex in selectedCardIndicies {
      fills.insert(self.drawnedCards[selectedCardIndex].fill)
      shapes.insert(self.drawnedCards[selectedCardIndex].shape)
      color.insert(self.drawnedCards[selectedCardIndex].color)
      numberOfElements.insert(self.drawnedCards[selectedCardIndex].numberOfItems)
    }
    
    return (fills.count != 2 && shapes.count != 2 && color.count != 2 && numberOfElements.count != 2)
  }
  
  mutating private func drawCards(_ numberOfCards: Int) -> [Card] {
    var numberOfCardsToDraw = numberOfCards
    if numberOfCardsToDraw > self.numberOfCardsNotYetPlayed {
      numberOfCardsToDraw = self.numberOfCardsNotYetPlayed
    }
    
    print("Drawing cards")
    var selectedCards: [Card] = []
    repeat {
      guard let cardIndex = self.cards.indices.randomElement() else {
        continue
      }
      
      selectedCards.append(self.cards[cardIndex])
      self.cards.remove(at: cardIndex)
    } while selectedCards.count < numberOfCardsToDraw
    
    return selectedCards
  }
  
  static private func generateCards() -> [Card] {
    var cards: [Card] = []
    
    for fillType in Card.Fill.allCases {
      for shape in Card.Shape.allCases {
        for numberOfElementInCard in 1..<Constants.maximumNumberOfElementsOnCard + 1 {
          for color in Constants.possibleCardColors {
            let card = Card(color: color, shape: shape,
                            fill: fillType, numberOfItems: numberOfElementInCard)
            cards.append(card)
          }
        }
      }
    }
    
    return cards
  }
  
  private func cardCurrentlyPlaying(_ card: Card) -> Bool {
    self.drawnedCards.contains { $0.id == card.id }
  }
  
  private enum Constants {
    static let maximumNumberOfElementsOnCard = 3
    static let numberOfCardVisible = 12
    static let possibleCardColors: [Color] = [.red, .blue, .orange]
    static let numberOfCardsToMatch = 3
  }
}


