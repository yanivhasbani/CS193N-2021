//
//  Cardify.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 18/03/2022.
//

import SwiftUI


// Informs that view that will put him, that this ViewModifier
// is responsible for it's own animation
// Any other animation will not apply to what's inside this
// view modifier
struct Cardify: Animatable, ViewModifier {
  private var cardBackColor: Gradient
  
  init(_ isFacedUp: Bool, _ cardBackColor: Gradient) {
    self.rotation = isFacedUp ? 0 : 180
    self.cardBackColor = cardBackColor
  }
  
  private var rotation: Double
  
  var animatableData: Double {
    get { self.rotation }
    set { self.rotation = newValue }
  }
  
  func body(content: Content) -> some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: Constants.Drawing.cornerRadius)
      if self.rotation < 90 {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: Constants.Drawing.lineWidth)
      } else {
        shape
          .fill(
            LinearGradient(gradient: self.cardBackColor,
                           startPoint: .topLeading, endPoint: .bottomTrailing)
          )
      }
      content.opacity(self.rotation < 90 ? 1 : 0)
    }.rotation3DEffect(Angle(degrees: self.rotation),
                       axis: (0, 1, 0))
  }
  
  enum Constants {
    enum Drawing {
      static let cornerRadius = 10.0
      static let lineWidth = 3.0
    }
  }
}

extension View {
  func cardify(_ isFacedUp: Bool, _ cardBackColor: Gradient) -> some View {
    self.modifier(Cardify(isFacedUp, cardBackColor))
  }
}
