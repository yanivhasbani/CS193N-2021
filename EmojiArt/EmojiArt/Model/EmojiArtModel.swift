//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import Foundation

struct EmojiArtModel {
  var background: Background = .blank
  var emojis = [Emoji]()
  
  init() { }
  
  private var uniqueEmojiId = 0
  
  mutating func addEmoji(_ text: String,
                         at location: (x: Int, y: Int),
                         size: Int) {
    self.uniqueEmojiId += 1
    
    let emoji = Emoji(text: text, x: location.x, y: location.y,
                      size: size, id: self.uniqueEmojiId)
    
    self.emojis.append(emoji)
  }
}

struct Emoji: Identifiable, Hashable {
  let text: String
  var x: Int // offset from the center
  var y: Int // offset from the center
  var size: Int
  let id: Int
  
  fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
    self.text = text
    self.x = x
    self.y = y
    self.size = size
    self.id = id
  }
}
