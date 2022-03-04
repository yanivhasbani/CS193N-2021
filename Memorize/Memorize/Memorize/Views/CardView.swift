//
//  CardView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct CardView: View {
  // Points to the heap
  // Even though our CardView is a struct, which makes it immutable, this @State is creating a pointer to something in th heap
  // Once somethings that is mentioned as a @State changes, than the SwiftUI system will recalculate the whole view system and rebuild this view
  @State var isFacedUp: Bool = true
  
  var content: String
  
  var body: some View {
    let shape = RoundedRectangle(cornerRadius: 20)
    
    ZStack {
      if self.isFacedUp {
        shape.fill(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(self.content).font(.largeTitle)
      } else {
        shape.fill()
      }
    }
    .foregroundColor(.red)
    .onTapGesture {
      self.isFacedUp = !self.isFacedUp
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(content: "🚗")
  }
}
