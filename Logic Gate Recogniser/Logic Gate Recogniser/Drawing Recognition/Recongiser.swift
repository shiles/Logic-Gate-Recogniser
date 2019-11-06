//
//  Recongiser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 05/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

typealias ConvexHull = [CGPoint]

class Recogniser {
    
    func convexHull(of cgPoints: [CGPoint]) -> ConvexHull {
        var points = cgPoints
        let minPoint = points.min { $0.y < $1.y }!
        
        //Remove smallest point before sorting
        points.remove(at: points.firstIndex(of: minPoint)!)
        
        //Sort by polar clockwise from minPoint
        points.sort {
            switch(orientation(from: minPoint, p1: $0, p2: $1)) {
            case .clockwise: return true
            case .anticlockwise: return false
            case .colinear: return squaredDistance(from: minPoint, to: $0) < squaredDistance(from: minPoint, to: $1)
            }
        }
    
        //Remove any points where a futher point is colinear
        for i in 0..<points.count {
            guard let p1 = points[safe: i], let p2 = points[safe: i+1] else { break}
            if orientation(from: minPoint, p1: p1, p2: p2) == .colinear { points.remove(at: i) }
        }
        
        //If there is less than three points the algorithm isn't possible
        if points.count < 3 { return ConvexHull() }
        
        var stack = Stack<CGPoint>(items: [minPoint, points[0], points[1]])
        
        //Build the convextHull
        for i in 2...points.lastIndex {
            guard let point = points[safe: i] else { break }
            while(orientation(from: stack.sndItem!, p1: stack.topItem!, p2:point) != .clockwise) { _ = stack.pop() }
            stack.push(point)
        }
            
        
        return stack.asList()
    }
    
    ///Finds the square distance between two points
    ///- Parameter p1: A Point within the drawing
    ///- Parameter p2: A Point within the drawing
    ///- Returns: Square of the distance between the two points
    private func squaredDistance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        return (p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y);
    }
    
    ///Finds the orientation of the triplet (minPoint, p1, p2)
    ///- Parameter minPoint: Minimum Y point in convexHull
    ///- Parameter p1: A Point within the drawing
    ///- Parameter p2: A Point within the drawing
    ///- Returns: The orientation of the triplet (minPoint, p1, p2)
    private func orientation(from minPoint: CGPoint, p1: CGPoint, p2: CGPoint) -> Orientation {
        let val = (p1.y - minPoint.y) * (p2.x - p1.x) - (p1.x - minPoint.x) * (p2.y - p1.y)
        if val == 0 { return .colinear }
        return val > 0 ? .clockwise : .anticlockwise
    }
    
}
