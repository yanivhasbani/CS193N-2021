//
//  MemoryGameFactories.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 05/03/2022.
//

import Foundation

struct MemoryGameFactory {
  static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
    MemoryGame(numberOfPairs: theme.symbols.count) { pairIndex in
      theme.symbols[pairIndex]
    }
  }
}

