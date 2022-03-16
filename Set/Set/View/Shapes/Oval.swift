//
//  Oval.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI

struct Oval: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    
    let partial = rect.width / 4
    path.move(to: CGPoint(x: center.x, y: center.y - partial))
    path.addLine(to: CGPoint(x: center.x - partial, y: center.y - partial))
    path.addArc(center: CGPoint(x: center.x - partial, y: center.y),
                radius: partial,
                startAngle: .degrees(-90),
                endAngle: .degrees(90),
                clockwise: true)
    path.addLine(to: CGPoint(x: center.x + partial, y: center.y + partial))
    path.addArc(center: CGPoint(x: center.x + partial,
                                y: center.y),
                radius: partial,
                startAngle: .degrees(90),
                endAngle: .degrees(-90),
                clockwise: true)
    path.addLine(to: CGPoint(x: center.x, y: center.y - partial))
    
    return path
  }
}

struct Oval_Previews: PreviewProvider {
  static var previews: some View {
    Oval()
      .stripes(.red)
      .foregroundColor(.red)
  }
}
