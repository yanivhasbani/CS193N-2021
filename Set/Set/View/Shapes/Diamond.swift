//
//  Diamond.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct Diamond: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let maxDimentsion = rect.maxDimentions
    let minLength = min(rect.width, rect.height)
    let padding = 0.0
    
    switch maxDimentsion {
    case .width:
      let center = CGPoint(x: rect.midX, y: rect.midY)
      let topCenter = CGPoint(x: center.x, y: padding)
      
      path.move(to: topCenter)
      path.addLine(to: CGPoint(x: center.x - minLength / 2 + padding,
                               y: center.y))
      path.addLine(to: CGPoint(x: center.x,
                               y: minLength - padding))
      path.addLine(to: CGPoint(x: center.x + minLength / 2 - padding,
                               y: center.y))
      path.addLine(to: CGPoint(x: topCenter.x - 1, y: topCenter.y - 1))
    case .height:
      let center = CGPoint(x: rect.midX, y: rect.midY)
      let topCenter = CGPoint(x: minLength / 2, y: center.y - minLength / 2)
      
      path.move(to: topCenter)
      path.addLine(to: CGPoint(x: 0, y: center.y))
      path.addLine(to: CGPoint(x: minLength / 2, y: center.y + minLength / 2))
      path.addLine(to: CGPoint(x: minLength, y: center.y))
      path.addLine(to: topCenter)
    }
    
    return path
  }
}

struct Diamond_Previews: PreviewProvider {
  static var previews: some View {
    Diamond()
      .stroke(lineWidth: 5.0)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
