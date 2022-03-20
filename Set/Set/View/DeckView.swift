//
//  DeckView.swift
//  Set
//
//  Created by Yaniv Hasbani on 20/03/2022.
//

import SwiftUI

struct DeckView: View {
  private var cards: [Card]
  private let title: String
  private var cardGeometryNamespace: Namespace.ID
  private let isCardFacedUp: Bool
  private let padding: CGFloat
  private let aspectRatio: CGFloat
  private let alignment: Alignment
  
  init(_ cards: [Card],
       _ title: String = "Draw",
       _ cardGeometryNamespace: Namespace.ID,
       _ isCardFacedUp: Bool,
       _ padding: CGFloat = Constant.Card.padding,
       _ aspectRatio: CGFloat = Constant.Card.aspectRatio,
       _ alignment: Alignment = .bottomLeading) {
    self.cards = cards
    self.title = title
    self.cardGeometryNamespace = cardGeometryNamespace
    self.isCardFacedUp = isCardFacedUp
    self.padding = padding
    self.aspectRatio = aspectRatio
    self.alignment = alignment
  }
  
  var body: some View {
    if self.cards.count == 0 {
      EmptyView()
    } else {
      ZStack {
        ForEach(self.cards) { card in
          CardView(card, self.isCardFacedUp)
            .matchedGeometryEffect(id: card.id, in: self.cardGeometryNamespace)
            .zIndex(10)
            .padding(self.padding)
            .aspectRatio(self.aspectRatio, contentMode: .fit)
            .transition(.asymmetric(insertion: .opacity, removal: .identity))
        }
        
        Text(self.title)
          .foregroundColor(.white)
          .padding()
          .zIndex(20)
      }
      .frame(width: Constant.Card.width,
             height: Constant.Card.height,
             alignment: self.alignment)
    }
  }
  
  private struct Constant {
    fileprivate struct Animation {

    }
    
    fileprivate struct Card {
      static let aspectRatio: CGFloat = 3 / 4
      static let padding: CGFloat = 5
      static let width: CGFloat = 80
      static let height: CGFloat = 100
    }
  }
}

struct DeckView_Previews: PreviewProvider {
  @Namespace static var cardGeometryNamespace
  
  static var previews: some View {
    let card1 = Card(color: .red, shape: .curly, fill: .full, numberOfItems: 3)
    let card2 = Card(color: .red, shape: .curly, fill: .full, numberOfItems: 3)
    let card3 = Card(color: .red, shape: .curly, fill: .full, numberOfItems: 3)
    let card4 = Card(color: .red, shape: .curly, fill: .full, numberOfItems: 3)
    
    DeckView([card1, card2, card3, card4],
             "Draw",
             self.cardGeometryNamespace,
             true,
             5,
             3 / 4,
             .bottomLeading)
  }
}
