//
//  ContentView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    VStack {
      Text("Memorize")
        .font(.largeTitle)
        .padding(.top)
      
      ScrollView {
        // Lazy refers to when the Grid actually gets the body var for each of the elements
        // In this case, it only gets the body content when the view is presented on screen
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
          // ForEach needs the class that we iterate to conform to Identifiable
          // String does not.
          // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
          // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
          ForEach(self.viewModel.cards) { card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                self.viewModel.choose(card)
              }
          }
        }
      }
      
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
        ForEach(Theme.allCases) { theme in
          Button {
            self.viewModel.themeSelected(theme)
          } label: {
            ZStack {
              Circle()
                .strokeBorder(lineWidth: 2, antialiased: true)
                
              
              VStack {
                Text(theme.representingEmoji)
                  .padding(.top)
                Text(theme.id)
                  .padding([.bottom])
              }
            }
            .foregroundColor(.red)
          }
          .padding(.top)
        }
      }
    }
    .padding(.horizontal)
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
