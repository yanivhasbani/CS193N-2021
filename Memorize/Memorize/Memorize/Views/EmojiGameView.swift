//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct EmojiGameView: View {
  @ObservedObject var game: EmojiMemoryGame
  
  @State private var dealt: Set<Int> = []
  @State private var finishedDrawing = false
  
  @Namespace var cardGeometryNamespace
  var body: some View {
    ZStack(alignment: .bottom) {
      VStack {
        gameHeadling
        gameBody
        gameBottomBar
      }
      .padding(.horizontal)
      
      gameDeck
    }
  }
  
  private var gameBody: some View {
    AspectVGrid(self.game.cards, aspectRatio: Constant.Card.aspectRatio) { card in
      if self.isUndelt(card) || (card.isMatched && !card.isFacedUp) {
        Color.clear
      } else {
        CardView(card, self.game.cardColor)
          .matchedGeometryEffect(id: card.id, in: self.cardGeometryNamespace)
          .padding(Constant.Card.padding)
          .transition(.asymmetric(insertion: .identity, removal: .scale))
          .zIndex(self.cardZIndex(card))
          .onTapGesture {
            withAnimation(.easeInOut(duration: Constant.Animation.cardFlipDuration)) {
              self.game.choose(card)
            }
          }
      }
    }
  }
  
  private var gameHeadling: some View {
    Group {
      Text("Score: \(self.game.score)")
        .font(.largeTitle)
        .padding(.vertical)
      
      Text(self.game.name)
        .foregroundStyle(
          LinearGradient(
            gradient: self.game.cardColor,
            startPoint: .topLeading,
            endPoint: .bottomLeading
          )
        )
        .font(.largeTitle)
        .padding(.top)
    }
  }
  
  private var gameBottomBar: some View {
    HStack(spacing: 5) {
      Button {
        if self.game.cards.count == self.dealt.count {
          withAnimation {
            self.game.shuffle()
          }
        }
      } label: {
        Text("Shuffle")
          .font(.title2)
      }.disabled(!self.finishedDrawing)
      
      Spacer()
      
      Button {
        withAnimation {
          self.dealt = []
          self.finishedDrawing = false
          self.game.newGame()
        }
      } label: {
        Text("New Game")
          .font(.title2)
      }
      .foregroundColor(.red)
    }
    .padding([.leading, .bottom, .trailing])
  }
  
  private var gameDeck: some View {
    ZStack {
      ForEach(self.game.cards.filter(isUndelt)) { dealtCard in
        CardView(dealtCard, self.game.cardColor)
          .padding(Constant.Card.padding)
          .aspectRatio(Constant.Card.aspectRatio, contentMode: .fit)
          .matchedGeometryEffect(id: dealtCard.id, in: self.cardGeometryNamespace)
          .transition(.asymmetric(insertion: .opacity, removal: .identity))
      }
    }
    .frame(width: Constant.Card.undealtWidth,
           height: Constant.Card.undealtHeight,
           alignment: .bottom)
    .onTapGesture {
      for card in self.game.cards {
        withAnimation(self.dealAnimation(card)) {
          self.deal(card)
        }
        
        let fullAnimationDuration = Double(self.game.cards.count) * (Constant.Animation.totalDealDuration / Double(self.game.cards.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + fullAnimationDuration + 0.3) {
          self.game.shuffle()
          self.finishedDrawing = true
        }
      }
    }
  }
  
  private func deal(_ card: EmojiMemoryGame.Card) {
    self.dealt.insert(self.game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
  }
  
  private func isUndelt(_ card: EmojiMemoryGame.Card) -> Bool {
    !self.dealt.contains { $0 == card.id }
  }
  
  private func dealAnimation(_ card: EmojiMemoryGame.Card) -> Animation {
    var delay = 0.0
    
    if let cardIndex = self.game.cards.firstIndex(where: {$0.id == card.id}) {
      delay = Double(cardIndex) * (Constant.Animation.totalDealDuration / Double(self.game.cards.count))
    }
    
    return Animation.easeInOut(duration: Constant.Animation.cardDealDuration).delay(delay)
  }
  
  private func cardZIndex(_ card: EmojiMemoryGame.Card) -> Double {
    -Double(self.game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
  }
  
  private struct Constant {
    fileprivate struct Drawing {
      static let gridMininumWidth: CGFloat = 80

    }
    
    fileprivate struct Animation {
      static let cardFlipDuration: CGFloat = 0.7
      static let cardDealDuration: CGFloat = 0.3
      static let totalDealDuration: Double = 2
    }
    
    fileprivate struct Card {
      static let color: Color = .red
      static let aspectRatio: CGFloat = 0.75
      static let padding: CGFloat = 4
      static let undealtWidth: CGFloat = 60
      static let undealtHeight: CGFloat = 90
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiGameView(game: EmojiMemoryGame(.vehicle))
      .preferredColorScheme(.dark)
    EmojiGameView(game: EmojiMemoryGame(.food))
      .preferredColorScheme(.light)
  }
}
