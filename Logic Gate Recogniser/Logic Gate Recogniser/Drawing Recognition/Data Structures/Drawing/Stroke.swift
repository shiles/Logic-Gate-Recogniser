//
//  Stroke.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

typealias Stroke = [CGPoint]

extension Stroke {
    
    var length: CGFloat {
        if self.count < 2 { return 0 }
        
        return (0...self.lastIndex-1).map {
            let next = self[$0+1], current = self[$0]
            return ((next.x - current.x).squared() + (next.y - current.y).squared()).squareRoot()
        }.reduce(0, +)
    }
    
    ///Gets the non-rotated bounding box of the stroke
    var boundingBox: CGRect {
        let path = UIBezierPath()
        path.move(to: self.first!)
        (1...self.lastIndex).forEach { path.addLine(to: self[$0]) }
        return path.bounds
    }
    
}
