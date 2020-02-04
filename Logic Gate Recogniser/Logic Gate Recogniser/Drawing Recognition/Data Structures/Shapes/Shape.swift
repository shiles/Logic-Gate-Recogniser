//
//  Shape.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/01/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

struct Shape: CustomStringConvertible {
    let type: ShapeType
    let convexHull: ConvexHull
}

enum ShapeType: String {
    case Line, Circle, Triangle, Rectangle, Unknown
}

extension Shape {
    
    ///Representation when printing for easier debug
    var description: String { "\(type.rawValue)" }
    
    ///Gets the non-rotated bounding box of the shape
    private var boundingBox: CGRect {
        let path = UIBezierPath()
        path.move(to: convexHull.first!)
        (1...convexHull.lastIndex).forEach { path.addLine(to: convexHull[$0]) }
        return path.bounds
    }
    
    ///Bounding box inflated to 110% size
    var inflatedBoundingBox: CGRect { boundingBox.inflate(by: 1.4) }
}
