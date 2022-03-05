import Foundation
import SwiftUI

enum Theme: Int, CaseIterable {
  case vehicle = 0
  case food = 1
  case animal = 2
  case emoji = 3
  case flag = 4
  case sports = 5
  
  var name: String {
    switch self {
    case .vehicle:
      return "Vehicle"
    case .food:
      return "Food"
    case .animal:
      return "Animal"
    case .emoji:
      return "Emoji"
    case .flag:
      return "Flag"
    case .sports:
      return "Sports"
    }
  }
  
  var cardColor: Gradient {
    switch self {
    case .vehicle:
      return Gradient(colors: [.blue, .green])
    case .food:
      return Gradient(colors: [.orange, .orange.opacity(0.4)])
    case .animal:
      return Gradient(colors: [.black, .white])
    case .emoji:
      return Gradient(colors: [.cyan, .teal])
    case .flag:
      return Gradient(colors: [.mint])
    case .sports:
      return Gradient(colors: [.teal, .blue])
    }
  }
  
  var numberOfCards: Int {
    let randomNumber = Int(arc4random()) % self.icons.count
    
    return randomNumber < 5 ? 5 : randomNumber
  }
  
  var icons: [String] {
    switch self {
    case .vehicle:
      return [
        "🚗", "🚛", "🚕", "✈️", "🛵",
        "🏍", "🛺", "🚃", "🚀", "🛸",
        "🚁", "🛶", "⛵️", "🚤", "🛥"
      ]
    case .food:
      return [
        "🍎", "🍐", "🍊", "🍉", "🍒",
        "🧅", "🥦", "🥐", "🥖", "🍭",
        "🥤", "🧋"
      ]
    case .animal:
      return [
        "🐶", "🐱", "🐭", "🙉", "🐸",
        "🐤", "🦉", "🦄", "🐞", "🪳",
        "🦂", "🐍", "🦃", "🐩"
      ]
    case .emoji:
      return [
        "😀", "😍", "🥸", "🥳", "😭",
        "😡", "🥶", "🥺", "🥱", "😱",
        "🤮", "👺", "👾", "😸", "🤠",
        "😽", "🤥", "🤗", "😙", "🥰"
      ]
    case .flag:
      return [
        "🏴", "🇦🇽", "🏳️", "🏴‍☠️", "🏁",
        "🇺🇳", "🇸🇴", "🇸🇦", "🇳🇮", "🇮🇱",
        "🇮🇹", "🇬🇷", "🇳🇿", "🇦🇷"
      ]
    case .sports:
      return [
        "🎱", "🏓", "🏈", "🏀", "⚽️",
        "🥎", "🏐", "🏒", "🥏", "🎽"
      ]
    }
  }
}
