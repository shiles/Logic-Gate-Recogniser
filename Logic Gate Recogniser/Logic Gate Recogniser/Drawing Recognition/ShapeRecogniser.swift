//
//  ShapeRecogniser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ShapeRecogniser {
    
    let analyser: ShapeAnalyser = ShapeAnalyser()
    let decider: ShapeDecider = ShapeDecider()
    let detailAnalyser: DetailAnalyser = DetailAnalyser()
    let combiner: ShapeCombiner = ShapeCombiner()
    
    ///Recognises the shape from a stroke that the user entered
    ///- Parameter stroke: CGPoints of users input on the canvas
    ///- Parameter adjacentShapes: The shapes which are grouped togther on the canvas
    ///- Returns: Retruns adjacent shapes with the analysed stroke added
    func recogniseShape(from stroke: Stroke, into adjacentShapes: [[Shape]]) -> [[Shape]] {
        guard let newShape = analyseStroke(stroke) else { return adjacentShapes }
        let shape = analyseShapeDetails(newShape)
        return findAdjacentShapes(shape: shape, in: adjacentShapes)
    }
    
    ///Combines the shapes that have already been recognised into more complex shapes or gates
    ///- Parameter adjacentShapes:: The shapes which are grouped togther on the canvas
    ///- Returns: Retruns adjacent shapes with the analysed stroke added
    func performAnalysis(in adjacentShapes: [[Shape]]) -> [[Shape]] {
        var shapes = adjacentShapes
        var i = 0
        
        while(i < shapes.count) {
            shapes[i] = combiner.combineToTriangle(shapes: shapes[i])
            shapes[i] = combiner.completeTriangleWithLine(shapes: shapes[i])
            shapes[i] = combiner.combineToRectangle(shapes: shapes[i])

            if let newList = combiner.combineShapesToGates(shapes: shapes[i]) {
                shapes[i] = newList
                i += 1
            } else {
               shapes.remove(at: i)
            }
        }
        
        return shapes
    }

    ///Removes the shapes that the user has indicated via they're stroke
    ///- Parameter erasorStroke: The stroke indicating what the user would like to remove
    ///- Parameter adjacentShapes: The shapes which are grouped togther on the canvas
    ///- Returns: Retruns adjacent shapes with the analysed stroke added
    func eraseShapes(eraserStroke: Stroke, in adjacentShapes: [[Shape]]) -> [[Shape]] {
        let eraserBoundingBox = eraserStroke.boundingBox
        var shapes: [[Shape]] = []
        
        adjacentShapes.forEach { list in
            if list.combinedBoundingBox.intersects(eraserBoundingBox) {
                var closeShapes: [Shape] = []
                
                list.forEach { shape in
                    if shape.boundingBox.intersects(eraserBoundingBox) {
                        let nonOverlapping = shape.components.filter { !$0.interesects(with: eraserStroke) }
                                          
                        if nonOverlapping.count == shape.components.count {
                            closeShapes.append(shape)
                        } else {
                            closeShapes.append(contentsOf: nonOverlapping.compactMap(analyseStroke).map(analyseShapeDetails))
                        }
                    } else {
                        closeShapes.append(shape)
                    }
                }

                if closeShapes.hasElements { shapes.append(closeShapes) }
            } else {
                shapes.append(list)
            }
        }
        
        return shapes
    }
    
    // MARK: -  Helper Functions
    
    ///Analyse the details of the shape that has been recognised to get additional information
    ///- Parameter shape: The shape that has been recognised
    ///- Returns: A shape with further analysis done
    private func analyseShapeDetails(_ shape: Shape) -> Shape {
        if shape.type == .triangle(type: .unanalysed) {
            let analysedType = detailAnalyser.analyseTriangle(triangle: shape.components.flatMap { $0 })
            return Shape(type: analysedType, convexHull: shape.convexHull, components: shape.components)
        }
               
        if shape.type == .rectangle {
            let analysedType = detailAnalyser.analyseRectangle(rectangle: shape.components.flatMap { $0 })
            return Shape(type: analysedType, convexHull: shape.convexHull, components: shape.components)
        }
        
        return shape
    }
    
    ///Analyses the stroke and finds the shape that corresponds to it
    ///- Parameter stroke: The stroke the user has drawn
    ///- Returns: A optional, if a shape has been found
    func analyseStroke(_ stroke: Stroke) -> Shape? {
        guard let hull = analyser.convexHull(of: stroke) else {
            guard let first = stroke.first, let last = stroke.last, first != last else { return nil }
            return Shape(type: .line(type: .straight), convexHull: [first, last], components: [stroke])
        }
        let triangle = analyser.largestAreaTriangle(using: hull) ?? Triangle.zero
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
    ///- Parameter adjacentShapes: The shapes which are grouped togther on the canvas
    ///- Returns: Retruns adjacent shapes with the analysed stroke added
    private func findAdjacentShapes(shape: Shape, in adjacentShapes: [[Shape]]) -> [[Shape]] {
        var shapes = adjacentShapes
        let boundingBox = shape.inflatedBoundingBox
        
        for (i, list) in shapes.enumerated() where list.contains(where: { $0.inflatedBoundingBox.intersects(boundingBox) }) {
            shapes[i].append(shape)
            return shapes
        }
        
        shapes.append([shape])
        return shapes
    }
    
}
