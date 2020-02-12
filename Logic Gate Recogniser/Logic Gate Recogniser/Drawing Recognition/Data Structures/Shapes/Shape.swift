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
    case circle, rectangle, unknown
    case line, curvedLine
    case unanalysedTriangle, straitTringle, curvedTriangle
}

extension Shape {
    
    ///Representation when printing for easier debug
    var description: String { "\(type.rawValue)" }
    
    ///Gets the non-rotated bounding box of the shape
    var boundingBox: CGRect {
        let path = UIBezierPath()
        path.move(to: convexHull.first!)
        (1...convexHull.lastIndex).forEach { path.addLine(to: convexHull[$0]) }
        return path.bounds
    }
    
    ///Bounding box inflated to 110% size
    var inflatedBoundingBox: CGRect { boundingBox.inflate(by: 1.4) }
}
