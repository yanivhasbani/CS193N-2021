//
//  Stripes.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

extension CGImage {
  static func generateStripePattern(
    colors: (UIColor, UIColor) = (.clear, .black),
    width: CGFloat = 2,
    ratio: CGFloat = 1) -> CGImage? {
      
      let context = CIContext()
      let stripes = CIFilter.stripesGenerator()
      stripes.color0 = CIColor(color: colors.0)
      stripes.color1 = CIColor(color: colors.1)
      stripes.width = Float(width)
      stripes.center = CGPoint(x: 1-width*ratio, y: 0)
      let size = CGSize(width: width, height: 1)
      
      guard
        let stripesImage = stripes.outputImage,
        let image = context.createCGImage(stripesImage, from: CGRect(origin: .zero, size: size))
      else { return nil }
      return image
    }
}

extension Shape {
  func stripes(angle: Double = 20, _ color: Color) -> AnyView {
    guard let stripePattern = CGImage.generateStripePattern(colors: (.clear, UIColor(color))) else {
      return AnyView(self)
    }
    
    return AnyView(
      Rectangle()
        .fill(ImagePaint(image: Image(decorative: stripePattern, scale: 1.0)))
        .scaleEffect(2)
          .rotationEffect(.degrees(angle))
        .clipShape(self)
    )
  }
}
