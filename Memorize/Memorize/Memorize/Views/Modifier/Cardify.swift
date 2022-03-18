//
//  Cardify.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 18/03/2022.
//

import SwiftUI

struct Cardify: ViewModifier {
  private var isFacedUp: Bool
  private var cardBackColor: Gradient
  
  init(_ isFacedUp: Bool, _ cardBackColor: Gradient) {
    self.isFacedUp = isFacedUp
    self.cardBackColor = cardBackColor
  }
  
  func body(content: Content) -> some View {
    let shape = RoundedRectangle(cornerRadius: Constants.Drawing.cornerRadius)
    if self.isFacedUp {
      shape.fill(.white)
      shape.strokeBorder(lineWidth: Constants.Drawing.lineWidth)
    } else {
      shape
        .fill(
          LinearGradient(gradient: self.cardBackColor,
                         startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
    content.opacity(self.isFacedUp ? 1 : 0)
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
