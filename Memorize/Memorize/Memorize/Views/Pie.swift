//
//  Pie.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 12/03/2022.
//

import SwiftUI

struct Pie: Shape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool = false
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let startPoint = CGPoint(
      x: center.x  + radius * CGFloat(cos(startAngle.radians)),
      y: center.y + radius * CGFloat(sin(startAngle.radians))
    )
    
    path.move(to: center)
    path.addLine(to: startPoint)
    path.addArc(
      center: center,
      radius: radius,
      startAngle: self.startAngle,
      endAngle: self.endAngle,
      clockwise: !self.clockwise
    )
    path.addLine(to: center)
    
    return path
  }
  
  
}
