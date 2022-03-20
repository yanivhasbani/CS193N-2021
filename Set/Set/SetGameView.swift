//
//  SetGameView.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var game: SetGame
  
  @Namespace var cardGeometryNamespace
  
  @State var localDealtCard: Set<Card> = []
  @State var discarded: Set<Card> = []
  
  private static var numberOfCardsAlreadyDrew: Int = 0
  private static var numberOfCardsToDraw: Int = 0
  
  private var undealtCards: [Card] {
    self.game.cards.filter { !$0.isPlaying && !self.discardedCard($0) }
  }
  
  private var discardedCards: [Card] {
    Array(self.discarded)
  }
  
  private var dealtCards: [Card] {
    return self.game.cards.filter {
      $0.isPlaying &&
      !self.discardedCard($0)
    }
  }
  
  private var undealtDeck: DeckView {
    DeckView(self.undealtCards, "Draw", self.cardGeometryNamespace, false)
  }
  
  private var discardedDeck: DeckView {
    DeckView(self.discardedCards, "", self.cardGeometryNamespace, true)
  }
  
  private var gameBody: some View {
    AspectVGrid(self.dealtCards,
                aspectRatio: DrawingConstants.cardAspectRatio) { card in
      GeometryReader { geometry in
        ZStack {
          if self.cardIsLocalyDealt(card) {
            CardView(card, true)
              .matchedGeometryEffect(id: card.id, in: self.cardGeometryNamespace)
              .zIndex(self.cardZIndex(card))
              .onTapGesture {
                self.choose(card)
              }
          } else {
            EmptyView()
              .frame(width: 0, height: 0, alignment: .top)
          }
        }.animation(.deal((self.dealtCards.firstIndex(of: card) ?? 0) - SetGameView.numberOfCardsAlreadyDrew,
                          SetGameView.numberOfCardsToDraw),
                    value: self.dealtCards)
      }
    }
  }
  
  private var gameFooter: some View {
    HStack(alignment: .center) {
      self.undealtDeck
        .onTapGesture {
          withAnimation {
            self.draw()
          }
        }
      
      Spacer(minLength: 40)
      
      self.discardedDeck
    }
    .padding(.horizontal, 5)
  }
  
  private func choose(_ card: Card) {
    let matchedIndices = self.game.cards.indices.filter({
      self.game.cards[$0].isMatched &&
      !self.discardedCard(self.game.cards[$0])
    })
    
    if matchedIndices.count == 3 {
      for matchCardIndex in matchedIndices.indices {
        _ = withAnimation(.deal(matchCardIndex, matchedIndices.count)) {
          self.discarded.insert(self.game.cards[matchedIndices[matchCardIndex]])
        }
      }
    }
    
    DispatchQueue.main.async {
      self.game.choose(card)
      self.localDealtCard = Set(self.dealtCards)
    }
  }
  
  private func draw() {
    var numberOfCardsToDraw = 3
    if self.dealtCards.count == 0 {
      numberOfCardsToDraw = 12
    }
    
    SetGameView.numberOfCardsAlreadyDrew = self.dealtCards.count
    SetGameView.numberOfCardsToDraw = numberOfCardsToDraw
    
    self.game.draw(numberOfCardsToDraw)
    
    let newlyDealtCardsIndices = self.dealtCards.indices.filter({
      !self.cardIsLocalyDealt(self.dealtCards[$0])
    })
    for dealtCardIndex in newlyDealtCardsIndices.indices {
      _ = withAnimation(.deal(dealtCardIndex, newlyDealtCardsIndices.count)) {
        self.localDealtCard.insert(self.dealtCards[newlyDealtCardsIndices[dealtCardIndex]])
      }
    }
  }
  
  var body: some View {
    VStack {
      self.gameBody
      self.gameFooter
    }
  }
  
  private func cardIsLocalyDealt(_ card: Card) -> Bool {
    self.localDealtCard.contains(card)
  }
  
  private func discardedCard(_ card: Card) -> Bool {
    self.discarded.contains(card)
  }
  
  private func cardZIndex(_ card: Card) -> Double {
    -Double(self.game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
  }
  
  enum DrawingConstants {
    static let cardAspectRatio: CGFloat = 3 / 4
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let setGame = SetGame()
    SetGameView(game: setGame)
      .preferredColorScheme(.dark)
  }
}
