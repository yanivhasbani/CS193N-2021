//
//  EmojiView.swift
//  EmojiArt
//
//  Created by Yaniv Hasbani on 26/03/2022.
//

import SwiftUI

struct EmojiView: View {
  let emoji: Emoji
  
  @State private var panOffset: CGSize = .zero
  @GestureState private var gesturePanOffset: CGSize = .zero
  @State private var steadyStateZoomScale: CGFloat = 1
  @GestureState private var gestureZoomScale: CGFloat = 1
  
  init(_ emoji: Emoji) {
    self.emoji = emoji
  }
  
  var body: some View {
    GeometryReader { geometry in
      Text(emoji.text)
        .font(.system(size: CGFloat(emoji.size)))
        .scaleEffect(self.steadyStateZoomScale)
        .position(
          self.position(for: emoji, in: geometry)
        )
    }
  }
  
  private func position(for emoji: Emoji,
                        in geometry: GeometryProxy) -> CGPoint {
    return self.convertFromEmojiCoordinates((emoji.x, emoji.y),
                                            in: geometry)
  }
  
  private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int),
                                           in geometry: GeometryProxy) -> CGPoint {
    let center = geometry.frame(in: .local).center
    let xCoordinate = center.x + CGFloat(location.x) * self.steadyStateZoomScale + self.panOffset.width
    let yCoordinate = center.y + CGFloat(location.y) * self.steadyStateZoomScale + self.panOffset.height
    
    
    return CGPoint(
      x: xCoordinate,
      y: yCoordinate
    )
  }
}

struct EmojiView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiView(EmojiView_Previews.getEmoji())
    EmojiView(EmojiView_Previews.getEmoji())
  }
  
  private static func getEmoji() -> Emoji {
    var emojiDoc = EmojiArtModel()
    if emojiDoc.emojis.count == 0 {
      emojiDoc.addEmoji("🤬", at: (0,0), size: 60)
    }
    
    return emojiDoc.emojis.first!
  }
}
