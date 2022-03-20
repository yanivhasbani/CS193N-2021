import SwiftUI

struct Card: Identifiable, Hashable {
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
  
  // User selected
  var isSelected: Bool = false
  // Matched
  var isMatched: Bool = false
  
  var isPlaying: Bool = false
  var isDiscarded: Bool = false
  
  @ViewBuilder func createShape() -> some View {
    VStack {
      switch (self.shape, self.fill, self.numberOfItems) {
      case (.curly, .stripped, 1):
        Squiggle()
          .stripes(self.color)
      case (.curly, .full, 1):
        Squiggle()
          .fill(self.color)
      case (.curly, .empty, 1):
        Squiggle()
          .stroke(lineWidth: 2)
      case (.diamond, .stripped, 1):
        Diamond()
          .stripes(self.color)
      case (.diamond, .full, 1):
        Diamond()
          .fill(self.color)
      case (.diamond, .empty, 1):
        Diamond()
          .stroke(lineWidth: 2)
      case (.elipse, .stripped, 1):
        Oval()
          .stripes(self.color)
      case (.elipse, .full, 1):
        Oval()
          .fill(self.color)
      case (.elipse, .empty, 1):
        Oval()
          .stroke(lineWidth: 2)
      case (.curly, .stripped, 2):
        Squiggle()
          .stripes(self.color)
        Squiggle()
          .stripes(self.color)
      case (.curly, .full, 2):
        Squiggle()
          .fill(self.color)
        Squiggle()
          .fill(self.color)
      case (.curly, .empty, 2):
        Squiggle()
          .stroke(lineWidth: 2)
        Squiggle()
          .stroke(lineWidth: 2)
      case (.diamond, .stripped, 2):
        Diamond()
          .stripes(self.color)
        Diamond()
          .stripes(self.color)
      case (.diamond, .full, 2):
        Diamond()
          .fill(self.color)
        Diamond()
          .fill(self.color)
      case (.diamond, .empty, 2):
        Diamond()
          .stroke(lineWidth: 2)
        Diamond()
          .stroke(lineWidth: 2)
      case (.elipse, .stripped, 2):
        Oval()
          .stripes(self.color)
        Oval()
          .stripes(self.color)
      case (.elipse, .full, 2):
        Oval()
          .fill(self.color)
        Oval()
          .fill(self.color)
      case (.elipse, .empty, 2):
        Oval()
          .stroke(lineWidth: 2)
        Oval()
          .stroke(lineWidth: 2)
      case (.curly, .stripped, 3):
        Squiggle()
          .stripes(self.color)
        Squiggle()
          .stripes(self.color)
        Squiggle()
          .stripes(self.color)
      case (.curly, .full, 3):
        Squiggle()
          .fill(self.color)
        Squiggle()
          .fill(self.color)
        Squiggle()
          .fill(self.color)
      case (.curly, .empty, 3):
        Squiggle()
          .stroke(lineWidth: 2)
        Squiggle()
          .stroke(lineWidth: 2)
        Squiggle()
          .stroke(lineWidth: 2)
      case (.diamond, .stripped, 3):
        Diamond()
          .stripes(self.color)
        Diamond()
          .stripes(self.color)
        Diamond()
          .stripes(self.color)
      case (.diamond, .full, 3):
        Diamond()
          .fill(self.color)
        Diamond()
          .fill(self.color)
        Diamond()
          .fill(self.color)
      case (.diamond, .empty, 3):
        Diamond()
          .stroke(lineWidth: 2)
        Diamond()
          .stroke(lineWidth: 2)
        Diamond()
          .stroke(lineWidth: 2)
      case (.elipse, .stripped, 3):
        Oval()
          .stripes(self.color)
        Oval()
          .stripes(self.color)
        Oval()
          .stripes(self.color)
      case (.elipse, .full, 3):
        Oval()
          .fill(self.color)
        Oval()
          .fill(self.color)
        Oval()
          .fill(self.color)
      case (.elipse, .empty, 3):
        Oval()
          .stroke(lineWidth: 2)
        Oval()
          .stroke(lineWidth: 2)
        Oval()
          .stroke(lineWidth: 2)
      default:
        Oval()
      }
    }
    .padding(.all, 20.0)
  }
}
