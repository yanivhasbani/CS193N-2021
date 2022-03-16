//
//  Dimension.swift
//  Set
//
//  Created by Yaniv Hasbani on 16/03/2022.
//

import Foundation
import UIKit

enum Dimension {
  case width
  case height
}

extension CGRect {
  var maxDimentions: Dimension {
    size.width > size.height ? .width : .height
  }
}

