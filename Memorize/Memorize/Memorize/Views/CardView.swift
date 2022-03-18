//
//  CardView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct CardView: View {
  typealias Card = MemoryGame<String>.Card
  
  let card: Card
  let cardBackColor: Gradient
  
  init(_ givenCard: Card, _ color: Gradient) {
    self.card = givenCard
    self.cardBackColor = color
  }
  
  var body: some View {
    GeometryReader { geomtry in
      ZStack {
        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -90 + 120))
          .padding(5)
          .opacity(0.6)
        Text(self.card.content)
          .rotationEffect(Angle.degrees(self.card.isMatched ? 340 : 0))
          .animation(Animation.linear(duration: 1.2)
                      .repeatForever(autoreverses: false),
                     value: self.card.isMatched)
          .font(Font.system(size: Constants.Drawing.fontSize))
          .scaleEffect(self.scale(thatFits: geomtry.size))
      }
      .cardify(self.card.isFacedUp, self.cardBackColor)
      .foregroundColor(.red)
    }
  }
  
  private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (Constants.Drawing.fontSize / Constants.Drawing.fontScale)
  }
  
  private struct Constants {
    struct Drawing {
      static let fontScale: CGFloat = 0.65
      static let fontSize: CGFloat = 35
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = MemoryGame<String>.Card(content: "🚗", id: 0)
    
    return CardView(card, Gradient(colors:[.black, .yellow]))
  }
}
