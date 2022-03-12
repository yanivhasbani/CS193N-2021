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
        
      ScrollView {
        // Lazy refers to when the Grid actually gets the body var for each of the elements
        // In this case, it only gets the body content when the view is presented on screen
        LazyVGrid(columns: [GridItem(.adaptive(minimum: DrawingConstants.gridMininumWidth))]) {
          // ForEach needs the class that we iterate to conform to Identifiable
          // String does not.
          // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
          // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
          ForEach(self.game.cards) { card in
            CardView(card, self.game.cardColor)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                self.game.choose(card)
              }
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
