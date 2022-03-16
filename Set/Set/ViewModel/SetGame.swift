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
    self.model.drawnedCards.filter { !$0.isMatched }
  }
  
  // MARK: Intents
  func choose(_ card: Card) {
    self.model.choose(card)
  }
  
  func draw() {
    self.model.draw()
  }
}
