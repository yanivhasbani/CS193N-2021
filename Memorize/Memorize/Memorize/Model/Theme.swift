import Foundation

enum Theme: CaseIterable, Identifiable {
  var id: String {
    switch self {
    case .vehicle:
      return "vehicle"
    case .food:
      return "food"
    case .animal:
      return "animal"
    case .emoji:
      return "emoji"
    case .flag:
      return "flag"
    }
  }
  
  case vehicle
  case food
  case animal
  case emoji
  case flag
  
  var representingEmoji: String {
    return self.symbols[0]
  }
  
  var symbols: [String] {
    switch self {
    case .vehicle:
      return [
        "🚗", "🚛"
      ]
//      return [
//        "🚗", "🚛", "🚕", "✈️", "🛵",
//        "🏍", "🛺", "🚃", "🚀", "🛸",
//        "🚁", "🛶", "⛵️", "🚤", "🛥"
//      ]
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
    }
  }
}
