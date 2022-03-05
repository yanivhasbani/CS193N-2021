//
//  MemoryGameFactories.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

struct MemoryGameFactory {
  static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
    let randomIcons = theme.icons.shuffled()
    
    return MemoryGame(theme: theme) { pairIndex in
      randomIcons[pairIndex]
    }
  }
}

