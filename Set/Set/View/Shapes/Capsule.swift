//
//  Capsule.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct SetCapsule: View {
  var body: some View {
    let paddingSize: CGFloat = 5.0
    
    GeometryReader { geometry in
      if geometry.size.height > geometry.size.width {
        Capsule()
          .frame(width: geometry.size.width - paddingSize,
                 height: (geometry.size.width - paddingSize) / 2,
                 alignment: .center)
          
        
        
      } else {
        Capsule()
          .frame(width: (geometry.size.width - paddingSize) / 2,
                 height: geometry.size.height - paddingSize)
      }
    }
  }
  
//  func path(in rect: CGRect) -> Path {
//    var path = Path()
//    let maxDimentsion = UIScreen.maxDimentions
//    let minLength = min(rect.width, rect.height)
//
//    switch maxDimentsion {
//    case .width:
//      let center = CGPoint(x: rect.midX, y: rect.midY)
//      let topCenter = CGPoint(x: center.x, y: 0)
//
//      path.move(to: topCenter)
//      path.addLine(to: CGPoint(x: center.x - minLength / 2, y: center.y))
//      path.addLine(to: CGPoint(x: center.x, y: minLength))
//      path.addLine(to: CGPoint(x: center.x + minLength / 2 , y: center.y))
//      path.addLine(to: topCenter)
//    case .height:
//      let center = CGPoint(x: rect.midX, y: rect.midY)
//      let topCenter = CGPoint(x: minLength / 2, y: center.y - minLength / 2)
//
//      path.move(to: topCenter)
//      path.addLine(to: CGPoint(x: 0, y: center.y))
//      path.addLine(to: CGPoint(x: minLength / 2, y: center.y + minLength / 2))
//      path.addLine(to: CGPoint(x: minLength, y: center.y))
//      path.addLine(to: topCenter)
//    }
//
//    return path
//  }
}

struct Capsule_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SetCapsule()
        .foregroundColor(.red)
      .previewInterfaceOrientation(.portraitUpsideDown)
      SetCapsule()
        .foregroundColor(.red)
        .previewInterfaceOrientation(.landscapeLeft)
    }
  }
}
