//
//  SetApp.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

@main
struct SetApp: App {
  var body: some Scene {
    WindowGroup {
      let setGame = SetGame()
      SetGameView(game: setGame)
    }
  }
}
