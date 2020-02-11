//
//  ShapeCombiner.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 10/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class ShapeCombiner {
    
    private let analyser = ShapeAnalyser()
    
    // MARK: Logic Gate Recognisers
    
    func findGates(shapes: [Shape]) {
        var gates = Gate.allTypes
        
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
            if shapes.has(matching: \.type == .straitTringle) {
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
        
        if(gates.count == 1) {
            print(gates)
        }
    }
    
    // MARK: Shape Combinators
    
    ///Combines the lines into a triangle if possible
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: A tirangle from combined lines or nil
    func combineLinesToTriangle(shapes: [Shape]) -> Shape? {
        let lines = shapes.shapes(matching: .isLine)
        
        if lines.count == 3 {
            guard let combinedHull = analyser.convexHull(of: lines.map(\.convexHull).reduce([],+)) else { return nil }
            
            if lines.has(matching: \.type == .curvedLine) {
                return Shape(type: .curvedTriangle, convexHull: combinedHull)
            }
            
            return Shape(type: .straitTringle, convexHull: combinedHull)
        }
        
        return nil
    }
}
