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
    ///- Returns: Lenght of the current vector
    func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    ///Returns the perpendicular vector
    ///- Returns: Perpendicular vector of current vector
    func perpendicular() -> CGVector {
        return CGVector(dx: -dy, dy: dx)
    }
    
    /* Calculate the dot product of two vectors */
    func dotProduct(_ vector: CGVector) -> CGFloat {
      return dx * vector.dx + dy * vector.dy
    }
    
    ///Divides the dx and dy fields of a CGVector by the same scalar value and
    static public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
      return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
    }
    
    static public func - (rhs: CGVector, lhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx - lhs.dx, dy: rhs.dy - lhs.dy)
    }

}
