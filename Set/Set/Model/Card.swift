import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  
  enum Shape: CaseIterable {
    case diamond
    case curly
    case elipse
  }
  
  enum Fill: CaseIterable {
    case empty
    case stripped
    case full
  }
  
  let color: Color
  let shape: Shape
  let fill: Fill
  let numberOfItems: Int
  
  var isSelected: Bool = false
  var isMatched: Bool = false
}
