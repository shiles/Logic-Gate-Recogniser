//
//  CGPoint+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    
    ///Bounding box of 50px around this point
    var boundingBox: CGRect { CGRect(center: self) }
    
    ///Equivelent vector represeting the point
    var vector: CGVector { CGVector(dx: x, dy: y) }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
