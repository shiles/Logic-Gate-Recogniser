//
//  ShapeRecogniser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import GameKit

class ShapeRecogniser {
    
    let analyser: ShapeAnalyser
    let decider: ShapeDecider
    let detailAnalyser: DetailAnalyser
    let combiner: ShapeCombiner
    
    private(set) var adjacentShapes: [[Shape]] = [] {
        didSet { print(adjacentShapes) }
    }
    
    init(analyser: ShapeAnalyser = ShapeAnalyser(),
         decider: ShapeDecider = ShapeDecider(),
         detailAnalyser: DetailAnalyser = DetailAnalyser(),
         shapeCombiner: ShapeCombiner = ShapeCombiner() ) {
        self.analyser = analyser
        self.decider = decider
        self.detailAnalyser = detailAnalyser
        self.combiner = shapeCombiner
    }
    
    ///Recognises the shape from a stroke that the user entered
    ///- Parameter stroke: CGPoints of users input on the canvas
    func recogniseShape(from stroke: Stroke) {
        // TODO: - MultiThread this for performance
        guard let hull = analyser.convexHull(of: stroke) else { return }
        guard let triangle = analyser.largestAreaTriangle(using: hull) else { return }
        let container = analyser.boundingBox(using: hull)

        let attributes = findShapeAttributes(stroke: stroke, hull: hull, triangle: triangle, boundingBox: container)
    
        var shape = decider.findShape(for: attributes)
        NotificationCenter.default.post(name: .shapeRecognised, object: shape)
        
        if shape.type == .unknown { return }
        
        if shape.type == .unanalysedTriangle {
            let analysedType = detailAnalyser.analyseTriangle(triangle: stroke)
            shape = Shape(type: analysedType, convexHull: shape.convexHull)
            NotificationCenter.default.post(name: .shapeRecognised, object: shape)
        }
        
        if shape.type == .rectangle {
            let analysedType = detailAnalyser.analyseRectangle(rectangle: stroke)
            shape = Shape(type: analysedType, convexHull: shape.convexHull)
            NotificationCenter.default.post(name: .shapeRecognised, object: shape)
        }
        
        findAdjacentShapes(shape: shape)
    }
    
    ///Combines the shapes that have already been recognised into more complex shapes or gates
    @objc func performAnalysis() {
        for (i, list) in adjacentShapes.enumerated() {
            adjacentShapes[i] = combiner.combineToTriangle(shapes: list)
            adjacentShapes[i] = combiner.combineToRectangle(shapes: list)
            
            if let newList = combiner.combineShapesToGates(shapes: list) {
                adjacentShapes[i] = newList
            } else {
                adjacentShapes.remove(at: i)
            }
        }
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
        return ShapeAttributes(convexHull: hull, thinnessRatio: thinnessRatio, triangleAreaRatio: triangleAreaRatio, rectanglePerimeterRatio: rectanglePerimeterRatio)
    }
    
    ///Find the shape that are ajacent to eachother based on what has been found
    ///- Parameter shape: Shape to add adjacent values too
    private func findAdjacentShapes(shape: Shape) {
        let boundingBox = shape.inflatedBoundingBox
        
        for (i, list) in adjacentShapes.enumerated() {
            if list.contains(where: { $0.inflatedBoundingBox.intersects(boundingBox) }) {
                adjacentShapes[i].append(shape)
                return
           }
        }
        
        adjacentShapes.append([shape])
    }
    
}
