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
    
    ///Converts the stroke to a list of lines
    ///- Returns:A list of lines within the stroke
    private func toLines() -> [Line] {
        (0...self.lastIndex-1).map { i in
            Line(startPoint: self[i], endPoint: self[i+1])
        }
    }
    
    ///Caclulates the length of the stroke
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
    
    ///Calculate if a stroke intersects with another stroke
    ///- Parameter stroke: Stroke to check if intersects with self
    ///- Returns: Wether the stroke intersects
    func interesects(with stroke: Stroke) -> Bool {
        let lines = stroke.toLines()
        
        for line in self.toLines() {
            let intersects = lines
                .filter{ line.boundingBox.intersects($0.boundingBox) }
                .map { areIntersecting(line1: line, line2: $0) }
                .reduce(false, { return $0 || $1 })
            if intersects == true { return true }
        }
    
        return false
    }
    
    ///Calculates wether two lines are intersecting each other
    ///- Parameter line1: First line to compare
    ///- Parameter line2: Second line to compare
    ///- Returns: Boolean value indicating wether the lines intersect
    private func areIntersecting(line1: Line, line2: Line) -> Bool {
       let o1 = orientation(p1: line1.startPoint, p2: line1.endPoint, p3: line2.startPoint)
       let o2 = orientation(p1: line1.startPoint, p2: line1.endPoint, p3: line2.endPoint)
       let o3 = orientation(p1: line2.startPoint, p2: line2.endPoint, p3: line1.startPoint)
       let o4 = orientation(p1: line2.startPoint, p2: line2.endPoint, p3: line1.endPoint)
    
       // General case
       if (o1 != o2 && o3 != o4) { return true }
     
       // Special Cases
       if (o1 == .colinear && onSegment(p1: line1.startPoint, p2: line2.endPoint, p3: line1.startPoint)) { return true }
       if (o2 == .colinear && onSegment(p1: line1.startPoint, p2: line2.endPoint, p3: line1.endPoint)) { return true }
       if (o3 == .colinear && onSegment(p1: line2.startPoint, p2: line1.startPoint, p3: line2.endPoint)) { return true }
       if (o4 == .colinear && onSegment(p1: line2.endPoint, p2: line1.endPoint, p3: line2.endPoint)) { return true }
     
       return false
    }
    
    ///Given three colinear points checks if the point `p2` is on the segment `p1p3`
    ///- Parameter p1: Point p1
    ///- Parameter p2: Point p2
    ///- Parameter p3: Point p3
    ///- Returns: A boolean value indicating wether point `p2` is on the segment `p1p3`
    private func onSegment(p1: CGPoint, p2: CGPoint, p3: CGPoint) -> Bool {
        if (p2.x <= Swift.max(p1.x, p3.x) && p2.x >= Swift.min(p1.x, p3.x) && p2.y <=  Swift.max(p1.y, p3.y) && p2.y >= Swift.min(p1.y, p3.y)) {
            return true;
        }

        return false;
    }
      
    ///Finds the orientation of the triplet (minPoint, p1, p2)
    ///- Parameter p1: Minimum Y point in convexHull
    ///- Parameter p2: A Point within the drawing
    ///- Parameter p2: A Point within the drawing
    ///- Returns: The orientation of the triplet (minPoint, p1, p2)
    private func orientation(p1: CGPoint, p2: CGPoint, p3: CGPoint) -> Orientation {
        let val = (p2.y - p1.y) * (p3.x - p2.x) - (p2.x - p1.x) * (p3.y - p2.y);
        if (val == 0) { return .colinear; }
        return (val > 0) ? .clockwise : .anticlockwise;
    }
}
