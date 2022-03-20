//
//  Card.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct CardView: View {
  let card: Card
  let isFacedUp: Bool
  
  init(_ card: Card, _ isFacedUp: Bool) {
    self.card = card
    self.isFacedUp = isFacedUp
  }
  
  var body: some View {
    ZStack {
      self.card
        .createShape()
        .cardify(self.card, self.isFacedUp)
    }
    .padding(.all, 5.0)
    .foregroundColor(self.card.color)
  }
  
  enum Constants {
    static let borderWidth = 5.0
    static let roundedCorners = 15.0
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = Card(color: .yellow,
                    shape: .curly,
                    fill: .stripped,
                    numberOfItems: 2)
    CardView(card, true)
    
    let card = Card(color: .black,
                    shape: .diamond,
                    fill: .stripped,
                    numberOfItems: 2)
    CardView(card, false)
    
    let card = Card(color: .purple,
                    shape: .elipse,
                    fill: .stripped,
                    numberOfItems: 3)
    CardView(card, true)
  }
}
