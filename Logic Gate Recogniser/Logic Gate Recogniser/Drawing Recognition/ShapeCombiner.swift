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
    
    // MARK: Logic Gate Recognisers
    
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
            if shapes.has(matching: \.type == .straightTriangle) {
                gates.remove(matching: .notContainsStraightTriangle)
            } else {
                gates.remove(matching: .notContainsCurvedTriangle)
            }
        } else {
            gates.remove(matching: .containsTriangle)
        }
        
        //Filter out gates that contain or don't contain lines
        if shapes.has(matching: \.type == .curvedLine) {
            gates.remove(matching: .notContainsLine)
        } else {
            gates.remove(matching: .containsLine)
        }
        
        guard let gate = gates.first, gates.count == 1 else { return shapes }
        let boundingBox = shapes.reduce(shapes.first!.boundingBox, { $0.union($1.boundingBox) })
        NotificationCenter.default.post(name: .gateRecognised, object: GateType.buildGate(of: gate, at: boundingBox))
        return nil
    }
    
    // MARK: Shape Combinators
    
    ///Combines the lines into a triangle if possible
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: An updated list of shapes
    func combineToTriangle(shapes: [Shape]) -> [Shape] {
        let lines = shapes.shapes(matching: .isLine)
        
        if lines.count == 3 {
            guard let combinedHull = analyser.convexHull(of: lines.map(\.convexHull).reduce([],+)) else { return shapes }
            let type: ShapeType = lines.has(matching: \.type == .curvedLine) ? .curvedTriangle : .straightTriangle
            let components = lines.map(\.componennts).flatMap { $0 }
            
            let triangle = Shape(type: type, convexHull: combinedHull, componennts: components)
            NotificationCenter.default.post(name: .shapeRecognised, object: triangle)
            
            var newList = shapes.withOut(matching: .isLine)
            newList.append(triangle)
            return newList
        }
            
        return shapes
    }
    
    ///Combines a line and rectangle into a rectangle
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: An updated list of shapes
    func combineToRectangle(shapes: [Shape]) -> [Shape] {
        let list = shapes.shapes(matching: \.type == .straightTriangle && \.type == .rectangle)
        
        if list.count == 2 {
            guard let combinedHull = analyser.convexHull(of: list.map(\.convexHull).reduce([], +)) else { return shapes }
            let components = list.map(\.componennts).flatMap { $0 }
            
            let rect = Shape(type: .rectangle, convexHull: combinedHull, componennts: components)
            NotificationCenter.default.post(name: .shapeRecognised, object: rect)
            
            var newList = shapes.withOut(matching: \.type == .straightTriangle && \.type == .rectangle)
            newList.append(rect)
            return newList
        }
        
        return shapes
    }
}
