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
            let next = self[($0+1) % self.count]
            let current = self[$0]
            return CGVector(dx: (next.x - current.x), dy: (next.y - current.y))
        }
    }
}
