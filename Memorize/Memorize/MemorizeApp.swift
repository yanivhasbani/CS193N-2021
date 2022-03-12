//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
  private let game = EmojiMemoryGame(.vehicle)
  
  var body: some Scene {
    WindowGroup {
      EmojiGameView(game:game)
    }
  }
}
