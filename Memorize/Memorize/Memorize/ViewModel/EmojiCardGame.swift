//
//  EmojiCardGame.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

class EmojiCardGame {
  private var model: MemoryGame<String>
  private var theme: Theme
  
  init(_ theme: Theme) {
    self.model = MemoryGameFactory.createMemoryGame(theme)
    self.theme = theme
  }
}
