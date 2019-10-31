//
//  CGVector+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 31/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension CGVector {
    
    ///Normalizes the vector described by the CGVector to length 1.0
    ///- Returns: Vector normalised to lenght of 1.0
    func normalized() -> CGVector {
      let len = length()
      return len>0 ? self / len : CGVector.zero
    }

    /// Returns the length (magnitude) of the vector described by the CGVector.
    public func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    ///Divides the dx and dy fields of a CGVector by the same scalar value and
    static public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
      return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }
}
