//
//  SetGame.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import Foundation

class SetGame: ObservableObject {
  @Published var model: Game = Game()
  
  var cards: [Card] {
    self.model.cards
  }
  
  // MARK: Intents
  func choose(_ card: Card) {
    self.model.choose(card)
  }
  
  func draw(_ numberOfCards: Int) {
    self.model.draw(numberOfCards)
  }
}
