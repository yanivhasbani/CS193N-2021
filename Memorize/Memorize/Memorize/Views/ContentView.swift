//
//  ContentView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  let gridMinimumWidth = 60.0
  
  var body: some View {
    VStack {
      Text("Score: \(self.viewModel.score)")
        .font(.largeTitle)
        .padding(.vertical)
      
      Text(self.viewModel.name)
        .font(.largeTitle)
        .padding(.top)
      
      ScrollView {
        // Lazy refers to when the Grid actually gets the body var for each of the elements
        // In this case, it only gets the body content when the view is presented on screen
        LazyVGrid(columns: [GridItem(.adaptive(minimum: self.gridMinimumWidth))]) {
          // ForEach needs the class that we iterate to conform to Identifiable
          // String does not.
          // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
          // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
          ForEach(self.viewModel.cards) { card in
            CardView(card: card, cardColor: self.viewModel.cardColor)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                self.viewModel.choose(card)
              }
          }
        }
      }
      
      Button {
        self.viewModel.newGame()
      } label: {
        Text("New Game")
          .font(.title)
      }
      .padding(.bottom)
    }
    .padding(.horizontal)
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  let cardColor: Gradient
  
  var body: some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if self.card.isMatched {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(self.card.content)
          .font(.largeTitle)
          .opacity(0.1)
      } else if self.card.isFacedUp {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(self.card.content)
          .font(.largeTitle)
      } else {
        shape
          .fill(
            LinearGradient(gradient: self.cardColor,
                           startPoint: .topLeading, endPoint: .bottomTrailing)
          )
      }
    }
    .foregroundColor(.red)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: EmojiMemoryGame(.vehicle))
      .preferredColorScheme(.dark)
    ContentView(viewModel: EmojiMemoryGame(.food))
      .preferredColorScheme(.light)
  }
}
