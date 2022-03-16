//
//  Card.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct CardView: View {
  let card: Card
  
  init(_ card: Card) {
    self.card = card
  }
  
  var body: some View {
    let shape = RoundedRectangle(cornerRadius: Constants.cardRoundedCorners)
    ZStack {
      if self.card.isSelected {
        shape.fill(.white)
        shape.fill(.purple.opacity(0.2))
      } else {
        shape.fill(.white)
      }
      shape
        .strokeBorder(lineWidth: Constants.cardBorderWidth)
      VStack(alignment: .center) {
        self.createShape()
      }
      .padding(.all, 20.0)
    }
    .padding(.all, 5.0)
    .foregroundColor(self.card.color)
  }
  
  @ViewBuilder func createShape() -> some View {
    let card = self.card
    
    switch (card.shape, card.fill, card.numberOfItems) {
    case (.curly, .stripped, 1):
      Squiggle()
        .stripes(self.card.color)
    case (.curly, .full, 1):
      Squiggle()
        .fill(self.card.color)
    case (.curly, .empty, 1):
      Squiggle()
        .stroke(lineWidth: 2)
    case (.diamond, .stripped, 1):
      Diamond()
        .stripes(self.card.color)
    case (.diamond, .full, 1):
      Diamond()
        .fill(self.card.color)
    case (.diamond, .empty, 1):
      Diamond()
        .stroke(lineWidth: 2)
    case (.elipse, .stripped, 1):
      Oval()
        .stripes(self.card.color)
    case (.elipse, .full, 1):
      Oval()
        .fill(self.card.color)
    case (.elipse, .empty, 1):
      Oval()
        .stroke(lineWidth: 2)
    case (.curly, .stripped, 2):
      Squiggle()
        .stripes(self.card.color)
      Squiggle()
        .stripes(self.card.color)
    case (.curly, .full, 2):
      Squiggle()
        .fill(self.card.color)
      Squiggle()
        .fill(self.card.color)
    case (.curly, .empty, 2):
      Squiggle()
        .stroke(lineWidth: 2)
      Squiggle()
        .stroke(lineWidth: 2)
    case (.diamond, .stripped, 2):
      Diamond()
        .stripes(self.card.color)
      Diamond()
        .stripes(self.card.color)
    case (.diamond, .full, 2):
      Diamond()
        .fill(self.card.color)
      Diamond()
        .fill(self.card.color)
    case (.diamond, .empty, 2):
      Diamond()
        .stroke(lineWidth: 2)
      Diamond()
        .stroke(lineWidth: 2)
    case (.elipse, .stripped, 2):
      Oval()
        .stripes(self.card.color)
      Oval()
        .stripes(self.card.color)
    case (.elipse, .full, 2):
      Oval()
        .fill(self.card.color)
      Oval()
        .fill(self.card.color)
    case (.elipse, .empty, 2):
      Oval()
        .stroke(lineWidth: 2)
      Oval()
        .stroke(lineWidth: 2)
    case (.curly, .stripped, 3):
      Squiggle()
        .stripes(self.card.color)
      Squiggle()
        .stripes(self.card.color)
      Squiggle()
        .stripes(self.card.color)
    case (.curly, .full, 3):
      Squiggle()
        .fill(self.card.color)
      Squiggle()
        .fill(self.card.color)
      Squiggle()
        .fill(self.card.color)
    case (.curly, .empty, 3):
      Squiggle()
        .stroke(lineWidth: 2)
      Squiggle()
        .stroke(lineWidth: 2)
      Squiggle()
        .stroke(lineWidth: 2)
    case (.diamond, .stripped, 3):
      Diamond()
        .stripes(self.card.color)
      Diamond()
        .stripes(self.card.color)
      Diamond()
        .stripes(self.card.color)
    case (.diamond, .full, 3):
      Diamond()
        .fill(self.card.color)
      Diamond()
        .fill(self.card.color)
      Diamond()
        .fill(self.card.color)
    case (.diamond, .empty, 3):
      Diamond()
        .stroke(lineWidth: 2)
      Diamond()
        .stroke(lineWidth: 2)
      Diamond()
        .stroke(lineWidth: 2)
    case (.elipse, .stripped, 3):
      Oval()
        .stripes(self.card.color)
      Oval()
        .stripes(self.card.color)
      Oval()
        .stripes(self.card.color)
    case (.elipse, .full, 3):
      Oval()
        .fill(self.card.color)
      Oval()
        .fill(self.card.color)
      Oval()
        .fill(self.card.color)
    case (.elipse, .empty, 3):
      Oval()
        .stroke(lineWidth: 2)
      Oval()
        .stroke(lineWidth: 2)
      Oval()
        .stroke(lineWidth: 2)
    default:
      Oval()
    }
  }
  
  enum Constants {
    static let cardBorderWidth = 5.0
    static let cardRoundedCorners = 15.0
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = Card(color: .yellow,
                    shape: .curly,
                    fill: .stripped,
                    numberOfItems: 2)
    CardView(card)
    
    let card = Card(color: .black,
                    shape: .diamond,
                    fill: .stripped,
                    numberOfItems: 2)
    CardView(card)
    
    let card = Card(color: .purple,
                    shape: .elipse,
                    fill: .stripped,
                    numberOfItems: 3)
    CardView(card)
  }
}
