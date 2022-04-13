//
//  EmojiView.swift
//  EmojiArt
//
//  Created by Yaniv Hasbani on 26/03/2022.
//

import SwiftUI

struct EmojiView: View {
  let emoji: Emoji
  
  init(_ emoji: Emoji) {
    self.emoji = emoji
  }
  
  var body: some View {
    GeometryReader { geometry in
      
    }
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
      emojiDoc.addEmoji("🤬", at: (0,0))
    }
    
    return emojiDoc.emojis.first!
  }
}
