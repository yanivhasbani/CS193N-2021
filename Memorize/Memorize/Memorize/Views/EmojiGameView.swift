//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct EmojiGameView: View {
  @ObservedObject var game: EmojiMemoryGame
  
  var body: some View {
    VStack {
      Text("Score: \(self.game.score)")
        .font(.largeTitle)
        .padding(.vertical)
      
      Text(self.game.name)
        .foregroundStyle(
          LinearGradient(
            gradient: self.game.cardColor,
            startPoint: .topLeading,
            endPoint: .bottomLeading
          )
        )
        .font(.largeTitle)
        .padding(.top)
        
      AspectVGrid(self.game.cards, aspectRatio: DrawingConstants.cardAspectRatio) { card in
        if card.isMatched {
          Rectangle().opacity(0)
        } else {
          CardView(card, self.game.cardColor)
            .padding(DrawingConstants.cardPadding)
            .onTapGesture {
              self.game.choose(card)
            }
        }
      }
      
      Button {
        self.game.newGame()
      } label: {
        Text("New Game")
          .font(.title)
      }
      .padding(.bottom)
    }
    .padding(.horizontal)
  }
  
  private struct DrawingConstants {
    static let gridMininumWidth: CGFloat = 80
    static let cardAspectRatio: CGFloat = 0.75
    static let cardPadding: CGFloat = 4
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiGameView(game: EmojiMemoryGame(.vehicle))
      .preferredColorScheme(.dark)
    EmojiGameView(game: EmojiMemoryGame(.food))
      .preferredColorScheme(.light)
  }
}
