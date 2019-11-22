//
//  ShapeDecider.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 21/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import GameKit

enum Shape: String {
    case Line, Circle, Triangle, Rectangle, Unknown
}

class ShapeDecider {
    
    let decisionTree: GKDecisionTree
    
    init() {
        decisionTree = GKDecisionTree(attribute: NSString(string: "PchSrdVsAch?"))
        let root  = decisionTree.rootNode!
        // Decides if its a line or a circle, or something else and moves to the next node
                _ = root.createBranch(predicate: NSPredicate(format: "SELF < %@", NSNumber(13.2)), attribute:  NSString(string: Shape.Circle.rawValue))
                _ = root.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(100.0)), attribute: NSString(string: Shape.Line.rawValue))
        let isTri = root.createBranch(predicate: NSPredicate(format: "SELF => %@ && SELF <= %@", NSNumber(13.2), NSNumber(100.0)), attribute: NSString(string: "AltVsAch?"))
        // Decides if its a triangle. or something else
                _ = isTri.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(0.75)), attribute:  NSString(string: Shape.Triangle.rawValue))
        let isRec = isTri.createBranch(predicate: NSPredicate(format: "SELF <= %@", NSNumber(0.75)), attribute:  NSString(string: "PchVsPbb?"))
        // Decides if its a rectangle. or unknown as we aren't sure what it might be
                _ = isRec.createBranch(predicate: NSPredicate(format: "SELF > %@", NSNumber(0.85)), attribute: NSString(string: Shape.Rectangle.rawValue))
                _ = isRec.createBranch(predicate: NSPredicate(format: "SELF <= %@", NSNumber(0.85)), attribute: NSString(string: Shape.Unknown.rawValue))
    }
    
    func findShape(for attributes: ShapeAttributes ) -> Shape {
        let answers = [
            NSString(string: "PchSrdVsAch?") : NSNumber(value: Float(attributes.PchSrdVsAch)),
            NSString(string: "AltVsAch?") : NSNumber(value: Float(attributes.AltVsAch)),
            NSString(string: "PchVsPbb?") : NSNumber(value: Float(attributes.PchVsPbb))
        ]
        
        print(answers)
        print(decisionTree)
        
        return Shape.init(rawValue: String(decisionTree.findAction(forAnswers: answers) as! NSString))!
    }
    
}