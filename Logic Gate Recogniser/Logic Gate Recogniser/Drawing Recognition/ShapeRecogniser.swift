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
    ///Convex Hull Perimeter Squared / Area Convex Hull
    let thinnessRatio: CGFloat
    
    ///Area Largest Triangle / Area Convex Hull
    let triangleAreaRatio: CGFloat
    
    ///Perimeter Convex Hull / Perimeter Bounding Box
    let rectanglePerimeterRatio: CGFloat
}

class ShapeRecogniser {
    
    let analyser: ShapeAnalyser
    let decider: ShapeDecider
    
    private var recognisedShapes: [Shape] = []
    
    init(analyser: ShapeAnalyser = ShapeAnalyser(), decider: ShapeDecider = ShapeDecider()) {
        self.analyser = analyser
        self.decider = decider
    }
    
    func recogniseShape(from stroke: Stroke) {
        // TODO: - MultiThread this for performance
        guard let hull = analyser.convexHull(of: stroke) else { return }
        guard let triangle = analyser.largestAreaTriangle(using: hull) else { return }
        let container = analyser.boundingBox(using: hull)

        let attributes = findShapeAttributes(stroke: stroke, hull: hull, triangle: triangle, boundingBox: container)
    
        let shape = decider.findShape(for: attributes)
        NotificationCenter.default.post(name: .gateRecognised, object: shape)
        
        // Don't process if the shape is unknown
        if shape.type == .Unknown { return }
        recognisedShapes.append(shape)
    }
    
    // MARK: -  Helper Functions
    
    ///Finds the attributes of the shape that's been drawn by the user that will the be used to classify the shape within the decision tree
    ///- parameter stroke: Users drawn stroke
    ///- parameter hull: Convex Hull of the shape drawn
    ///- parameter triangle: Maximum area triangle within the shape
    ///- parameter boundingbox: Minimum area bounding box for shape
    ///- Returns: ShapeAttribues to allow for a decision on the shape that was drawn
    private func findShapeAttributes(stroke: Stroke, hull: ConvexHull, triangle: Triangle, boundingBox: BoundingBox) -> ShapeAttributes {
        let thinnessRatio = hull.perimeter!.squared() / hull.area
        let triangleAreaRatio = triangle.area / hull.area
        let rectanglePerimeterRatio = hull.perimeter! / boundingBox.perimeter!
        return ShapeAttributes(thinnessRatio: thinnessRatio, triangleAreaRatio: triangleAreaRatio, rectanglePerimeterRatio: rectanglePerimeterRatio)
    }
    
}
