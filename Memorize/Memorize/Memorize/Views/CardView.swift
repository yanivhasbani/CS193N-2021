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
  
  @State private var animatedBonusRemaining: Double = 0
  
  var body: some View {
    GeometryReader { geomtry in
      ZStack {
        Group {
          if self.card.isConsumingBonusTime {
            Pie(startAngle: Angle(degrees: Constants.Animation.changePieStartPointFromRightCenterToUpCenter),
                endAngle: Angle(degrees: (1 - self.animatedBonusRemaining) * 360 + Constants.Animation.changePieStartPointFromRightCenterToUpCenter))
              .onAppear {
                self.animatedBonusRemaining = self.card.bonusRemaining
                withAnimation(.linear(duration: self.card.bonusTimeRemaining)) {
                  self.animatedBonusRemaining = 0
                }
              }
          } else {
            Pie(startAngle: Angle(degrees: Constants.Animation.changePieStartPointFromRightCenterToUpCenter),
                endAngle: Angle(degrees: (1 - self.card.bonusRemaining) * 360 + Constants.Animation.changePieStartPointFromRightCenterToUpCenter))
          }
        }
          .padding(5)
          .opacity(0.6)
        
        Text(self.card.content)
          .rotationEffect(Angle.degrees(self.card.isMatched ? 360 : 0))
          .animation(Animation.linear(duration: Constants.Animation.cardMatchRotationTime)
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
    fileprivate struct Drawing {
      static let fontScale: CGFloat = 0.65
      static let fontSize: CGFloat = 35
    }
    
    fileprivate struct Animation {
      static let cardMatchRotationTime = 1.0
      static let changePieStartPointFromRightCenterToUpCenter = -89.0
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = MemoryGame<String>.Card(content: "🚗", id: 0)
    
    return CardView(card, Gradient(colors:[.black, .yellow]))
  }
}
