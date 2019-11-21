//
//  ShapeRecogniser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import GameKit

struct ShapeAttributes {
    let stokeLength: CGFloat
    let hullPerimeter: CGFloat
    let hullArea: CGFloat
    let bbPerimeter: CGFloat
}

class ShapeRecogniser {
    
    let analyser: ShapeAnalyser
    
    init(analyser: ShapeAnalyser = ShapeAnalyser()) {
        self.analyser = analyser
    }
    
    func recogniseShape(from stroke: Stroke) {
        // TODO: MultiThread this for performance
        guard let hull = analyser.convexHull(of: stroke) else { return }
        guard let triangle = analyser.largestAreaTriangle(using: hull) else { return }
        let container = analyser.boundingBox(using: hull)

        let attributes = findShapeAttributes(stroke: stroke, hull: hull, triangle: triangle, boundingBox: container)
        
    }
    
    ///Finds the attributes of the shape that's been drawn by the user that will the be used to classify the shape within the decision tree
    ///- parameter stroke: Users drawn stroke
    ///- parameter hull: Convex Hull of the shape drawn
    ///- parameter triangle: Maximum area triangle within the shape
    ///- parameter boundingbox: Minimum area bounding box for shape
    ///- Returns: ShapeAttribues to allow for a decision on the shape that was drawn
    private func findShapeAttributes(stroke: Stroke, hull: ConvexHull, triangle: Triangle, boundingBox: BoundingBox) -> ShapeAttributes {
        return ShapeAttributes(stokeLength: stroke.length,
                               hullPerimeter: hull.perimeter!,
                               hullArea: hull.area,
                               bbPerimeter: boundingBox.perimeter!)
    }
    
    
}
