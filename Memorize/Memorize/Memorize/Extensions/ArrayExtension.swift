import Foundation

extension Array {
  var oneAndOnly: Element? {
    if self.count == 1 {
      return self.first
    }
    
    return nil
  }
}
