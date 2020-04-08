//
//  ShapeCombiner.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 10/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class ShapeCombiner {
    
    private let analyser = ShapeAnalyser()
    private let details = DetailAnalyser()
    
    // MARK: Logic Gate Recogniser
    
    ///Combines the shapes into gates, when one is found a notification will be sent within the `.gateRecognised` channel
    ///- Parameter shapes: A list of shapes to analyse and check if a gate can be found
    ///- Returns: An optional, returns a list of shapes if nothings found and a nil value if one is found indicating they're used
    func combineShapesToGates(shapes: [Shape]) -> [Shape]? {
        var gates = GateType.allTypes
        
        //Filter out gates that contain or don't contain circles
        if shapes.has(matching: \.type == .circle) {
            gates.remove(matching: .notContainsCircle)
        } else {
            gates.remove(matching: .containsCircle)
        }
        
        //Filter out gates that contain or don't contain rectangles
        if shapes.has(matching: \.type == .rectangle) {
            gates.remove(matching: .notContainsRectangle)
        } else {
            gates.remove(matching: .containsRectangle)
        }
        
        //Filter out gates that contain or don't contain triangle
        if shapes.has(matching: .isTriangle) {
            if shapes.has(matching: \.type == .triangle(type: .straight)) {
                gates.remove(matching: .notContainsStraightTriangle)
            } else {
                gates.remove(matching: .notContainsCurvedTriangle)
            }
        } else {
            gates.remove(matching: .containsTriangle)
        }
        
        //Filter out gates that contain or don't contain lines
        if shapes.has(matching: \.type == .line(type: .curved)) {
            gates.remove(matching: .notContainsLine)
        } else {
            gates.remove(matching: .containsLine)
        }
    
        guard let gate = gates.first, gates.count == 1 else { return shapes }
        let boundingBox = shapes.combinedBoundingBox
        NotificationCenter.default.post(name: .gateRecognised, object: GateType.buildGate(of: gate, at: boundingBox))
        return nil
    }
    
    // MARK: Shape Combinators
    
    ///Combines the lines into a triangle if possible
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: An updated list of shapes
    func combineToTriangle(shapes: [Shape]) -> [Shape] {
        guard case let lines = shapes.shapes(matching: .isLine), lines.count == 3 else { return shapes }
        
        guard let combinedHull = analyser.convexHull(of: lines.map(\.convexHull).reduce([],+)) else { return shapes }
        let type: ShapeType = .triangle(type: lines.has(matching: \.type == .line(type: .curved)) ? .curved : .straight)
        
        let triangle = Shape(type: type, convexHull: combinedHull, components: lines.combinedComponents)
        
        var newList = shapes.withOut(matching: .isLine)
        newList.append(triangle)
        return newList
    }
    
    ///Combines a line and an incomplete triangle
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: An update list of shapes
    func completeTriangleWithLine(shapes: [Shape]) -> [Shape] {
        let lines = shapes.shapes(matching: .isLine)
        let incompleteTriangles = shapes.shapes(matching: \.type == .triangle(type: .incomplete))
        guard lines.hasElements && incompleteTriangles.hasElements else { return shapes }
        
        guard let line = lines.first, let incompleteTriangle = incompleteTriangles.first else { return shapes }
        guard let combinedHull = analyser.convexHull(of: [line.convexHull, incompleteTriangle.convexHull].reduce([],+)) else { return shapes }
        let type: ShapeType = .triangle(type: line.type == .line(type: .straight) ? .straight : .curved)
        
        let triangle = Shape(type: type, convexHull: combinedHull, components:  [line, incompleteTriangle].combinedComponents)
        
        var newList = shapes
        newList.removeAll(where: { $0 == line || $0 == incompleteTriangle })
        newList.append(triangle)
        return newList
    }
    
    ///Combines a line and a curved line into a rectangle
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: An update list of shapes
    func combineToRectangle(shapes: [Shape]) -> [Shape] {
        let straightLines = shapes.shapes(matching: \.type == .line(type: .straight))
        let curvedLines = shapes.shapes(matching: \.type == .line(type: .curved))
        
        guard let straight = straightLines.first, let curved = curvedLines.first else { return shapes }
        guard let combinedHull = analyser.convexHull(of: [straight, curved].map(\.convexHull).reduce([], +)) else { return shapes }
        
        let rect = Shape(type: .rectangle, convexHull: combinedHull, components: [straight, curved].combinedComponents)
        
        var newList = shapes
        newList.removeAll(where: { $0 == straight || $0 == curved })
        newList.append(rect)
        return newList
    }
}
