//
//  DealAnimation.swift
//  Set
//
//  Created by Yaniv Hasbani on 20/03/2022.
//

import SwiftUI

extension Animation {
  static func deal(_ index: Int, _ totalNumberOfCards: Int) -> Animation {
    if totalNumberOfCards == 0 {
      return Animation.default
    }
    
    let delay = Double(index) * (Constants.Animation.totalDealDuration / Double(totalNumberOfCards))
    
    return Animation.easeInOut(duration: Constants.Animation.cardDealDuration).delay(delay)
  }
  
  private struct Constants {
    struct Animation {
      static let cardFlipDuration: CGFloat = 0.7
      static let cardDealDuration: CGFloat = 0.2
      static let totalDealDuration: Double = 1
    }
  }
}
