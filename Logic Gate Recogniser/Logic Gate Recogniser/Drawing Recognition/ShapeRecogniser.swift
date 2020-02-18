//
//  ShapeRecogniser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

class ShapeRecogniser {
    
    let analyser: ShapeAnalyser = ShapeAnalyser()
    let decider: ShapeDecider = ShapeDecider()
    let detailAnalyser: DetailAnalyser = DetailAnalyser()
    let combiner: ShapeCombiner = ShapeCombiner()
    
    ///Recognises the shape from a stroke that the user entered
    ///- Parameter stroke: CGPoints of users input on the canvas
    func recogniseShape(from stroke: Stroke, into adjacentShapes: [[Shape]]) -> [[Shape]] {
        guard let newShape = analyseStroke(from: stroke) else { return adjacentShapes }
        var shape = newShape
        
        if shape.type == .unanalysedTriangle {
            let analysedType = detailAnalyser.analyseTriangle(triangle: stroke)
            shape = Shape(type: analysedType, convexHull: shape.convexHull, components: shape.components)
        }
        
        if shape.type == .rectangle {
            let analysedType = detailAnalyser.analyseRectangle(rectangle: stroke)
            shape = Shape(type: analysedType, convexHull: shape.convexHull, components: shape.components)
        }
        
        NotificationCenter.default.post(name: .shapeRecognised, object: shape)
        return findAdjacentShapes(shape: shape, in: adjacentShapes)
    }
    
    ///Combines the shapes that have already been recognised into more complex shapes or gates
    func performAnalysis(in adjacentShapes: [[Shape]]) -> [[Shape]] {
        var shapes = adjacentShapes
        
        for (i, _) in shapes.enumerated() {
            shapes[i] = combiner.combineToTriangle(shapes: shapes[i])
            shapes[i] = combiner.combineToRectangle(shapes: shapes[i])
            
            if let newList = combiner.combineShapesToGates(shapes: shapes[i]) {
                shapes[i] = newList
            } else {
                shapes.remove(at: i)
            }
        }
        
        return shapes
    }
    
    func eraseShapes(erasorStroke: Stroke, in adjacentShapes: [[Shape]]) -> [[Shape]] {
        var shapes: [[Shape]] = []
        
        adjacentShapes.forEach { list in
            var closeShapes: [Shape] = []
            
            list.forEach { shape in
                let nonOverlapping = shape.components.filter { !$0.interesects(with: erasorStroke) }
                
                if nonOverlapping.count == shape.components.count {
                    closeShapes.append(shape)
                } else {
                    closeShapes.append(contentsOf: nonOverlapping.compactMap(analyseStroke(from:)))
                }
            }
            
            if closeShapes.hasElements { shapes.append(closeShapes) }
        }
        
        return shapes
    }
    
    // MARK: -  Helper Functions
    
    private func analyseStroke(from stroke: Stroke) -> Shape? {
        guard let hull = analyser.convexHull(of: stroke) else { return nil }
        guard let triangle = analyser.largestAreaTriangle(using: hull) else { return nil }
        let container = analyser.boundingBox(using: hull)

        let attributes = findShapeAttributes(stroke: stroke, hull: hull, triangle: triangle, boundingBox: container)
        
        var shape = decider.findShape(for: attributes)
        shape.components.append(stroke)
        return shape
    }
    
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
    private func findAdjacentShapes(shape: Shape, in adjacentShapes: [[Shape]]) -> [[Shape]] {
        var shapes = adjacentShapes
        let boundingBox = shape.inflatedBoundingBox
        
        for (i, list) in shapes.enumerated() {
            if list.contains(where: { $0.inflatedBoundingBox.intersects(boundingBox) }) {
                shapes[i].append(shape)
                return shapes
           }
        }
        
        shapes.append([shape])
        return shapes
    }
    
}
