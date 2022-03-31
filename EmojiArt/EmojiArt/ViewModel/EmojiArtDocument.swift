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
  
  func addEmoji(_ emoji: String, at location: (x: Int, y: Int), size: CGFloat) {
    self.emojiArt.addEmoji(emoji, at: location, size: Int(size))
  }
  
  func moveEmoji(_ emoji: Emoji, by offset: CGSize) {
    if let index = self.emojiArt.emojis.index(matching: emoji) {
      self.emojiArt.emojis[index].x += Int(offset.width)
      self.emojiArt.emojis[index].y += Int(offset.height)
    }
  }
  
  func scaleEmoji(_ emoji: Emoji,
                  by scale: CGFloat) {
    if let index = self.emojiArt.emojis.index(matching: emoji) {
      self.emojiArt.emojis[index].size = Int(
        (CGFloat(self.emojiArt.emojis[index].size) * scale).rounded(.toNearestOrAwayFromZero)
      )
    }
  }
}
