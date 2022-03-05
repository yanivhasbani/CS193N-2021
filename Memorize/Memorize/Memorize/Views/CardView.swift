//
//  CardView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct CardView: View {
  let card: MemoryGame<String>.Card
  
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
        shape.fill()
      }
    }
    .foregroundColor(.red)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = MemoryGame<String>.Card(content: "🚗")
    CardView(card: card)
  }
}
