//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

class EmojiArtDocument: ObservableObject
{
  @Published private(set) var emojiArt: EmojiArtModel {
    didSet {
      if self.emojiArt.background != oldValue.background {
        self.fetchBackgroundImageDataIfNecessary()
      }
    }
  }
  
  init() {
    self.emojiArt = EmojiArtModel()
    //        emojiArt.addEmoji("😀", at: (-200, -100), size: 80)
    //        emojiArt.addEmoji("😷", at: (50, 100), size: 40)
  }
  
  var emojis: [Emoji] { self.emojiArt.emojis }
  var background: EmojiArtModel.Background { self.emojiArt.background }
  
  // MARK: - Background
  
  @Published var backgroundImage: UIImage?
  @Published var backgroundImageFetchStatus: BackgroundImageFetchStatus = .idle
  
  enum BackgroundImageFetchStatus {
    case idle
    case fetching
  }
  
  private func fetchBackgroundImageDataIfNecessary() {
    self.backgroundImage = nil
    switch self.emojiArt.background {
    case .url(let url):
      // fetch the url
      self.backgroundImageFetchStatus = .fetching
      DispatchQueue.global(qos: .userInitiated).async {
        let imageData = try? Data(contentsOf: url)
        DispatchQueue.main.async { [weak self] in
          if self?.emojiArt.background == EmojiArtModel.Background.url(url) {
            self?.backgroundImageFetchStatus = .idle
            if imageData != nil {
              self?.backgroundImage = UIImage(data: imageData!)
            }
          }
        }
      }
    case .imageData(let data):
      self.backgroundImage = UIImage(data: data)
    case .blank:
      break
    }
  }
  
  // MARK: - Intent(s)
  
  func setBackground(_ background: EmojiArtModel.Background) {
    self.emojiArt.background = background
  }
  
  func positioningEmoji(_ emojiString: String,
                        position dropPosition: CGPoint,
                        in geometry: GeometryProxy) {
    if let index = self.emojiArt.emojis.firstIndex(where: {emoji in emoji.text == emojiString}) {
      let center = geometry.frame(in: .local).center
      let panOffsetWidth = self.emojiArt.emojis[index].panOffsetWidth
      let panOffsetHeight = self.emojiArt.emojis[index].panOffsetHeight
      let zoomScale = self.emojiArt.emojis[index].zoomScale
      
      let location = CGPoint(
        x: (dropPosition.x - panOffsetWidth - center.x) / zoomScale,
        y: (dropPosition.y - panOffsetHeight - center.y) / zoomScale
      )
      
      self.emojiArt.emojis[index].x = Int(location.x)
      self.emojiArt.emojis[index].y = Int(location.y)
      
      self.emojiArt.emojis[index].hidden = false
    }
  }
  
  func position(for emoji: Emoji, in geometry: GeometryProxy) -> CGPoint {
    let center = geometry.frame(in: .local).center
    
    return CGPoint(
      x: center.x + CGFloat(emoji.x) * emoji.zoomScale + emoji.panOffsetWidth,
      y: center.y + CGFloat(emoji.y) * emoji.zoomScale + emoji.panOffsetHeight
    )
  }
  
  private func addEmoji(_ emoji: String, at location: (x: Int, y: Int), size: CGFloat) {
    self.emojiArt.addEmoji(emoji, at: location, size: Int(size))
  }
  
  func moveEmojies(_ emojies: [Emoji], by offset: CGSize) {
    for emoji in emojies {
      self.moveEmoji(emoji, by: offset)
    }
  }
  
  func moveEmoji(_ emoji: Emoji, by offset: CGSize) {
    if let index = self.emojiArt.emojis.index(matching: emoji) {
      self.emojiArt.emojis[index].x += Int(offset.width)
      self.emojiArt.emojis[index].y += Int(offset.height)
    }
  }
  
  func scaleEmojies(_ emojies: [Emoji], by scale: CGFloat) {
    for emoji in emojies {
      self.scaleEmoji(emoji, by: scale)
    }
  }
  
  func scaleEmoji(_ emoji: Emoji, by scale: CGFloat) {
    if let index = self.emojiArt.emojis.index(matching: emoji) {
      self.emojiArt.emojis[index].size = Int(
        (CGFloat(self.emojiArt.emojis[index].size) * scale).rounded(.toNearestOrAwayFromZero)
      )
    }
  }
}
