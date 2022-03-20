//
//  Cardify.swift
//  Set
//
//  Created by Yaniv Hasbani on 20/03/2022.
//

import SwiftUI

struct Cardify: ViewModifier {
  private var card: Card
  private var isFacedUp: Bool
  
  init(_ card: Card, _ isFacedUp: Bool) {
    self.card = card
    self.isFacedUp = isFacedUp
  }
  
  func body(content: Content) -> some View {
    let shape = RoundedRectangle(cornerRadius: Constants.Drawing.roundedCorners)
    if self.isFacedUp {
      if self.card.isDiscarded {
        shape.fill(.white)
      } else if self.card.isMatched {
        shape.fill(.white)
        shape.fill(.green.opacity(0.5))
      } else if self.card.isSelected {
        shape.fill(.white)
        shape.fill(.orange.opacity(0.3))
      } else {
        shape.fill(.white)
      }
      
      shape
        .strokeBorder(lineWidth: Constants.Drawing.borderWidth)
      content
    } else {
      shape.fill(.red)
    }
  }
  
  
  private struct Constants {
    struct Drawing {
      static let borderWidth = 5.0
      static let roundedCorners = 10.0
    }
  }
}

extension View {
  func cardify(_ card: Card, _ isFacedUp: Bool) -> some View {
    self.modifier(Cardify(card, isFacedUp))
  }
}
