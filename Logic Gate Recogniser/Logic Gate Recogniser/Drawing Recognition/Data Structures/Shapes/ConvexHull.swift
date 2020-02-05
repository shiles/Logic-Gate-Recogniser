//
//  ConvexHull.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 15/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit

typealias ConvexHull = [CGPoint]

extension ConvexHull {
    
    /// Edges around the convex hull including last to first point
    var edges: [CGVector] {
        return (0...self.lastIndex).map {
            let current = self[$0], next = self[circular: $0+1]!
            return CGVector(dx: (next.x - current.x), dy: (next.y - current.y))
        }
    }
    
    /// Perimeter lenght for the convex hull
    var perimeter: Perimeter? { Perimeter.perimeter(of: self) }
    
    /// Area fot the convex hull (Shoelace Method)
    var area: CGFloat {
        var lhs: CGFloat = 0, rhs: CGFloat = 0
        
        for i in 0...self.lastIndex {
            let current = self[i], next = self[circular: i+1]!
            lhs += current.x * next.y
            rhs += next.x * current.y
        }
        
        return abs(lhs-rhs) / 2
    }
}
