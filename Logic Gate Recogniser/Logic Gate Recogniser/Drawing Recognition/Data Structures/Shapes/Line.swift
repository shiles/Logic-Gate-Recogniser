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
    
    // Calculated variables
    var length: CGFloat { ((endPoint.x - startPoint.x).squared() + (endPoint.y - startPoint.y).squared()).squareRoot() }
    var vector: CGVector { self.transformToVector() }
}

extension Line {
    
    ///Transform the line into a vector which has been transfromed to the origin (0,0).
    ///- Returns:The equivelent vector at 0,0
    func transformToVector() -> CGVector {
        let transEnd = endPoint.applying(CGAffineTransform(translationX: -startPoint.x, y: -startPoint.y))
        return CGVector(dx: transEnd.x, dy: transEnd.y)
    }
}
