//
//  ShapeDecider.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 21/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import GameKit

class ShapeDecider {
    
    let decisionTree: GKDecisionTree
    
    init() {
        decisionTree = GKDecisionTree(attribute: NSString(string: "ThinnessRatio?"))
        let root  = decisionTree.rootNode!
        // Decides if its a line or a circle, or something else and moves to the next node
        _ = root.createBranch(predicate: NSPredicate(format: "SELF < %@", NSNumber(14.0)), attribute:  NSString(string: ShapeType.Circle.rawValue))
                _ = root.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(100.0)), attribute: NSString(string: ShapeType.Line.rawValue))
        let isTri = root.createBranch(predicate: NSPredicate(format: "SELF => %@ && SELF <= %@", NSNumber(13.2), NSNumber(100.0)), attribute: NSString(string: "TriangleAreaRatio?"))
        // Decides if its a triangle. or something else
                _ = isTri.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(0.75)), attribute:  NSString(string: ShapeType.UnanalysedTriangle.rawValue))
        let isRec = isTri.createBranch(predicate: NSPredicate(format: "SELF <= %@", NSNumber(0.75)), attribute:  NSString(string: "RectanglePerimeterRatio?"))
        // Decides if its a rectangle. or unknown as we aren't sure what it might be
                _ = isRec.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(0.85)), attribute: NSString(string: ShapeType.Rectangle.rawValue))
                _ = isRec.createBranch(predicate: NSPredicate(format: "SELF <= %@", NSNumber(0.85)), attribute: NSString(string: ShapeType.Unknown.rawValue))
    }
    
    func findShape(for attributes: ShapeAttributes) -> Shape {
        let answers = [
            NSString(string: "ThinnessRatio?") : NSNumber(value: Float(attributes.thinnessRatio)),
            NSString(string: "TriangleAreaRatio?") : NSNumber(value: Float(attributes.triangleAreaRatio)),
            NSString(string: "RectanglePerimeterRatio?") : NSNumber(value: Float(attributes.rectanglePerimeterRatio))
        ]
        
        print(answers)
        print(decisionTree)
        
        let type = ShapeType.init(rawValue: String(decisionTree.findAction(forAnswers: answers) as! NSString))!
        
        return Shape(type: type, convexHull: attributes.convexHull)
    }
    
}
