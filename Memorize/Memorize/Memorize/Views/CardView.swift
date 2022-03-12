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
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        if self.card.isFacedUp {
          shape.fill(.white)
          shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
          Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -90 + 120))
            .padding(5)
            .opacity(0.6)
          Text(self.card.content)
            .font(self.font(in: geomtry.size))
        } else {
          shape
            .fill(
              LinearGradient(gradient: self.cardBackColor,
                             startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        }
      }
      .foregroundColor(.red)
    }
  }
  
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
  }
  
  private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.65
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = MemoryGame<String>.Card(content: "🚗", id: 0)
    
    return CardView(card, Gradient(colors:[.black, .yellow]))
  }
}
