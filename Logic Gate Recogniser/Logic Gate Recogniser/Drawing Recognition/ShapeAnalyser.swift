//
//  Recongiser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 05/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class ShapeAnalyser {
        
    // MARK: - Minimum Area Bounding Box
        
    ///Find the bouding box within a convex hull with the smallest ara
    ///- Parameter convexHull: Convex hull to find the bounding box for
    ///- Returns: Boudning box with the smallest area
    func boundingBox(using convexHull: ConvexHull) -> BoundingBox {
        let transposedMatrix = convexHull.transposedMatrix               // Calculated once to save doing it for each edge
        let edgeAngles = convexHull
            .edges                                                       // Calculate all the edges on the convex hull
            .map { atan2($0.dy, $0.dx) }                                 // Calculate the edge angles
            .map { abs($0.truncatingRemainder(dividingBy: (.pi/2)) ) }   // Check the angles are in the first quadrant (modulo)
            .unique                                                      // Find all the unique edges
        
        // Test each angle to find bounding box with smallest area
        var minBox = MinBoudingRect(rotAngle: 0, area: CGFloat.greatestFiniteMagnitude, minX: 0, maxX: 0, minY: 0, maxY: 0)
        edgeAngles.forEach { angle in
            // Rotate the points
            let rotation = Matrix<CGFloat>.forRotation(angle: angle)
            let rotatedPoints = rotation.matrixMultiply(by: transposedMatrix)
    
            // Find min/max x & y points
            let minX = rotatedPoints[.row, 0].min()!
            let maxX = rotatedPoints[.row, 0].max()!
            let minY = rotatedPoints[.row, 1].min()!
            let maxY = rotatedPoints[.row, 1].max()!
            
            // Find attributes
            let width  = maxX - minX
            let height = maxY - minY
            let area   = width * height
            
            if area < minBox.area {
                minBox = MinBoudingRect(rotAngle: angle, area: area, minX: minX, maxX: maxX, minY: minY, maxY: maxY)
            }
        }
        
        // Re-create smallest rotation angle and rotate back to reference frame
        let rotation = Matrix<CGFloat>.forRotation(angle: minBox.rotAngle)
        let point1 = Matrix<CGFloat>(from: [minBox.maxX, minBox.minY]).matrixMultiply(by: rotation).toPoint()
        let point2 = Matrix<CGFloat>(from: [minBox.minX, minBox.minY]).matrixMultiply(by: rotation).toPoint()
        let point3 = Matrix<CGFloat>(from: [minBox.minX, minBox.maxY]).matrixMultiply(by: rotation).toPoint()
        let point4 = Matrix<CGFloat>(from: [minBox.maxX, minBox.maxY]).matrixMultiply(by: rotation).toPoint()

        return BoundingBox(cornerPoints: CornerPoints(p1: point1, p2: point2, p3: point3, p4: point4), area: minBox.area)
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
    func convexHull(of stroke: Stroke) -> ConvexHull? {
        if stroke.count < 3 { return nil }
        var points = stroke
        
        //Remove smallest point before sorting
        let minPoint = points.removeMinPoint()
        
        //Sort by polar clockwise from minPoint
        points.sort {
            switch(orientation(from: minPoint, p1: $0, p2: $1)) {
            case .clockwise: return true
            case .anticlockwise: return false
            case .colinear: return squaredDistance(from: minPoint, to: $0) < squaredDistance(from: minPoint, to: $1)
            }
        }
    
        //Remove any points where a futher point is colinear
        var i = 0
        while(i < points.lastIndex) {
            if orientation(from: minPoint, p1: points[i], p2: points[i+1]) == .colinear {
                points.remove(at: i)
            } else { i += 1 }
        }
        
        //If there is less than three points the algorithm isn't possible
        if points.count < 3 { return nil }
        var stack = Stack<CGPoint>(items: [minPoint, points[0], points[1]])
        
        //Build the convextHull
        for i in 2...points.lastIndex {
            let point = points[i]
            while(orientation(from: stack.sndItem!, p1: stack.topItem!, p2:point) != .clockwise) {
                _ = stack.pop()
            }
            stack.push(point)
        }
            
        return stack.asList()
    }
    
    ///Finds the square distance between two points
    ///- Parameter p1: A Point within the drawing
    ///- Parameter p2: A Point within the drawing
    ///- Returns: Square of the distance between the two points
    private func squaredDistance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        return (p1.x - p2.x).squared() + (p1.y - p2.y).squared();
    }
    
    ///Finds the orientation of the triplet (minPoint, p1, p2)
    ///- Parameter minPoint: Minimum Y point in convexHull
    ///- Parameter p1: A Point within the drawing
    ///- Parameter p2: A Point within the drawing
    ///- Returns: The orientation of the triplet (minPoint, p1, p2)
    private func orientation(from minPoint: CGPoint, p1: CGPoint, p2: CGPoint) -> Orientation {
        let val = (p1.y - minPoint.y) * (p2.x - p1.x) - (p1.x - minPoint.x) * (p2.y - p1.y)
        if val == 0 {
            return .colinear
        }
        return val > 0 ? .anticlockwise : .clockwise
    }
    
}
