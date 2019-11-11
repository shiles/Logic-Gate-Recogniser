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

struct MinAreaRect {
    // Normalised & Converted Axis'
    let xAxis: CGVector
    let yAxis: CGVector
    
    // Corners - Index in convexHull
    let bIndex: Int
    let rIndex: Int
    let tIndex: Int
    let lIndex: Int

    // Total are
    let area: CGFloat
}

class Recogniser {
    
    // MARK: - Minimum Area Bounding Box
    
    func boundingBox(using convexHull: ConvexHull) -> MinAreaRect {
        let vectors = convexHull.map { $0.toVector() }
        return minimumAreaRectangle(p1Index: vectors.count-1, p2Index: 0, convexHull: vectors)
    }
    
    private func minimumAreaRectangle(p1Index: Int, p2Index: Int, convexHull: [CGVector]) -> MinAreaRect {
        // Get Points
        let point1 = convexHull[p1Index], point2 = convexHull[p2Index]
        
        // Axises & Origin to convert all the points too
        let origin = point2
        let xAxis  = point2 - point1
        let yAxis  = xAxis.perpendicular()
        
        // Temporary storage
        var bIndex = p2Index, rIndex = 0, tIndex = 0, lIndex = 0
        var right = CGVector(), top = CGVector(), left = CGVector()
        
        // Find Extreme Points
        for i in 0..<convexHull.count {
            let diff = convexHull[i] - origin
            let vertex = CGVector(dx: xAxis.dotProduct(diff), dy: yAxis.dotProduct(diff))
            
            if vertex.dx > right.dx || (vertex.dx == right.dx && vertex.dy > right.dy) {
                right = vertex
                rIndex = i
            }
            
            if vertex.dy > top.dy || (vertex.dy == top.dy && vertex.dx < top.dx) {
                top = vertex
                tIndex = i
            }
            
            if vertex.dx < left.dx || (vertex.dx == left.dx && vertex.dy < left.dy) {
                left = vertex
                lIndex = i
            }
        }
        
        let area = (right.dx - left.dx) * top.dy
        return MinAreaRect(xAxis: xAxis, yAxis: yAxis, bIndex: bIndex, rIndex: rIndex, tIndex: tIndex, lIndex: lIndex, area: area)
    }
    
    // MARK: - Largest Area Triangle
    
    ///Find the triangle within a convex hull with the largest area using
    ///- Parameter convexHull: Convex hull to find the triangle in
    ///- Returns: Triangle with the largest area
    func largestAreaTriangle(using cH: ConvexHull) -> Triangle? {
        let count = cH.count
        if count < 3 { return nil }
        var iA = 0, iB = 1, iC = 2
        var bestA = cH[iA], bestB = cH[iB], bestC = cH[iC]
    
        while true {
            while true {
                // Move point c around until the area of the next iteration's area is smaller
                while Triangle.area(a: cH[iA], b: cH[iB], c: cH[iC]) <= Triangle.area(a: cH[iA], b: cH[iB], c: cH[(iC+1) % count]) {
                    iC = (iC+1) % count
                }
                // Move point b one place, and keep it that way if the area is larger
                if Triangle.area(a: cH[iA], b: cH[iB], c: cH[iC]) <= Triangle.area(a: cH[iA], b: cH[(iB+1) % count], c: cH[iC]) {
                    iB = (iB + 1) % count  // Incremenet, then loop again increasing C
                } else { break }
            }
            
            // If the new triangle is better than our old one, use it
            if Triangle.area(a: bestA, b: bestB, c: bestC) < Triangle.area(a: cH[iA], b: cH[iB], c: cH[iC]) {
                bestA = cH[iA]; bestB = cH[iB]; bestC = cH[iC]
            }
            
            // Increment A, rotate shape if needed
            iA = (iA + 1) % count
            if iA == iB { iB = (iB + 1) % count }
            if iB == iC { iC = (iC+1) % count }
            if iA == 0  { break }
        }
    
        return Triangle(a: bestA, b: bestB, c: bestC)
    }
    
    // MARK: - Convex Hull
    
    ///Find the convex hull of a set of points using Graham Scan Algorithm
    ///- Parameter cgPoints: Points to find convex hull of
    ///- Returns: Convex hull of the points
    func convexHull(of cgPoints: [CGPoint]) -> ConvexHull? {
        if cgPoints.count < 3 { return nil }
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
        if points.count < 2 { return nil }
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
        return val > 0 ? .anticlockwise : .clockwise
    }
    
}
