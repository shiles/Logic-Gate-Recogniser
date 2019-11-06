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
    var area: CGFloat { 0.5 * ((b.x - a.x)*(c.y - a.y) - (c.x - a.x)*(b.y - a.y)) }
}

extension Triangle {
    static func area(a: CGPoint, b: CGPoint, c: CGPoint) -> CGFloat {
        return 0.5 * ((b.x - a.x)*(c.y - a.y) - (c.x - a.x)*(b.y - a.y))
    }
}
