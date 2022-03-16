//
//  SetGameView.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var game: SetGame
  
  var body: some View {
    AspectVGrid(self.game.cards,
                aspectRatio: DrawingConstants.cardAspectRatio) { card in
      CardView(card)
        .onTapGesture {
          self.game.choose(card)
        }
    }
    
    Button {
      self.game.draw()
    } label: {
      Text("Draw")
          .fontWeight(.bold)
          .font(.system(size: 10))
          .padding()
          .background(Color.purple)
          .cornerRadius(40)
          .foregroundColor(.white)
    }
  }
  
  enum DrawingConstants {
    static let cardAspectRatio: CGFloat = 3 / 4
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let setGame = SetGame()
    SetGameView(game: setGame)
      .preferredColorScheme(.dark)
  }
}
