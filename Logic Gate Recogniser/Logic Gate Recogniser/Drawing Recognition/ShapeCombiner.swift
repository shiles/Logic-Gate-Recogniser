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
    
    ///Combines the lines into a triangle if possible
    ///- Parameter shapes: A list of shapes to analyse
    ///- Returns: A tirangle from combined lines or nil
    func combineLinesToTriangle(shapes: [Shape]) -> Shape? {
        let lines = shapes.shapes(matching: .isLine)
        
        if lines.count == 3 {
            guard let combinedHull = analyser.convexHull(of: lines.map(\.convexHull).reduce([],+)) else { return nil }
            
            if lines.contains(where: Predicate.isCurved.matches) {
                return Shape(type: .curvedTriangle, convexHull: combinedHull)
            }
            
            return Shape(type: .straitTringle, convexHull: combinedHull)
        }
        
        return nil
    }
    
}
