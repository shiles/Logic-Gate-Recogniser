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
    // Variables
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    ///Length of the line
    var length: CGFloat { ((endPoint.x - startPoint.x).squared() + (endPoint.y - startPoint.y).squared()).squareRoot() }
    
    ///Transform the line into a vector which has been transfromed to the origin (0,0).
    var vector: CGVector {
        endPoint.applying(CGAffineTransform(translationX: -startPoint.x, y: -startPoint.y)).toVector()
    }
}
