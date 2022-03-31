//
//  SelectedEmojiView.swift
//  EmojiArt
//
//  Created by Yaniv Hasbani on 26/03/2022.
//

import SwiftUI

struct SelectedView: ViewModifier {
  let isSelected: Bool
  
  init(_ isSelected: Bool) {
    self.isSelected = isSelected
  }
  
  func body(content: Content) -> some View {
    if self.isSelected {
      content.opacity(0.4)
    } else {
      content
    }
  }
}

extension View {
  func selected(_ isSelected: Bool) -> some View {
    self.modifier(SelectedView(isSelected))
  }
}
