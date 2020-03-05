//
//  Triangle.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 06/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

struct Triangle {
    let a: CGPoint
    let b: CGPoint
    let c: CGPoint
    
    ///Area of the triangle
    var area: CGFloat { Triangle.area(a: a, b: b, c: c)}
}

extension Triangle {
    
    ///Calculates the area of a triangle with vertexes given by the points
    ///- Parameter a: Point `a`
    ///- Parameter b: Point `b`
    ///- Parameter c: Point `c`
    ///- Returns: Area of the traingle with vertexes (`a`, `b`, `c`)
    static func area(a: CGPoint, b: CGPoint, c: CGPoint) -> CGFloat {
        return 0.5 * ((b.x - a.x)*(c.y - a.y) - (c.x - a.x)*(b.y - a.y))
    }
    
    ///Initialises an empty triangle
    static var zero: Triangle {
        Triangle(a: CGPoint.zero, b: CGPoint.zero, c: CGPoint.zero)
    }
}
