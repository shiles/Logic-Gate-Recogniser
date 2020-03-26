//
//  Line.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 30/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

struct Line: Equatable {
    var startPoint: CGPoint
    var endPoint: CGPoint
  
    ///Transform the line into a vector which has been transfromed to the origin (0,0).
    var vector: CGVector {
        endPoint.applying(CGAffineTransform(translationX: -startPoint.x, y: -startPoint.y)).vector
    }
    
    ///Gets the non-rotated bounding box of the stroke
    var boundingBox: CGRect {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path.bounds
    }
    
    ///Gets the length of the line
    var length: CGFloat {
        ((endPoint.x - startPoint.x).squared() + (endPoint.y - startPoint.y).squared()).squareRoot()
    }
}
