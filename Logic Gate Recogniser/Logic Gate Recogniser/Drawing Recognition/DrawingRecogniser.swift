//
//  DrawingRecogniser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 25/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit
import Accelerate

struct Line {
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    var length: CGFloat {
        return ((endPoint.x - startPoint.x).squared() + (endPoint.y - startPoint.y).squared()).squareRoot()
    }
}

class DrawingRecogniser {
    
    func recogniseShape(points: [CGPoint]) -> [Line] {
        let orderedPoints = points.reversed().map { $0 }
        let straitLines = recogniseStraitLines(points: orderedPoints)

        for i in 0...straitLines.count {
            guard let first = straitLines[safe: i], let second = straitLines[safe: i+1] else { break }
            let angle = angleBetwen(between: first, second)
            print(angle?.toDegrees() as Any)
        }
        
        return straitLines
    }
    
    ///Finds the angle between two lines if the first point's end and the second point's line interesect
    ///- Parameter first: First line drawn cronologically
    ///- Parameter second: Second line drawn cronologically
    ///- Returns: Angle between lines if valid, or nil.
    private func angleBetwen(between first: Line, _ second: Line) -> Angle? {
        guard first.endPoint == second.startPoint else { return nil }
       
        let missingSide = Line(startPoint: second.endPoint, endPoint: first.startPoint)
        let a = missingSide.length
        let b = first.length
        let c = second.length
        
        return acos((b.squared() + c.squared() - a.squared()) / (2.0 * b * c))
    }
    
    ///Finds all the strait lines within the points.
    ///- Parameter points: Points of the line to check for strait lines
    ///- Returns: A list of strait lines
    private func recogniseStraitLines(points: [CGPoint]) -> [Line] {
        if recogniseStraitLine(points: points) {
            return [ Line(startPoint: points.last!, endPoint:  points.first!) ]
        }
        
        let split = points.split()
        return recogniseStraitLines(points: split.right) + recogniseStraitLines(points: split.left)
    }
    
    ///Checks if the lines strait based on an allowed devience via root mean squared of all the points.
    ///- Parameter points: Points of the line to check if is straight
    ///- Parameter allowedDevience: Allowed devience to determine if the line is strait or not, defualt is 5.0
    ///- Returns: A boolean indicating if the line is strait or not
    private func recogniseStraitLine(points: [CGPoint], allowedDevience: CGFloat = 5.0) -> Bool {
        let xCoords = translate(points: points).map { $0.x }
        let rms = xCoords.rootMeanSquared()
        return rms < allowedDevience
    }
    
 
    /// Finds the rotation angle between a first and a last point, used to rotate the whole line relative to this slope.
    ///- Parameter first: First point of the line
    ///- Parameter last: Last point of the line
    ///- Returns: Angle between points in radions
    private func rotationAngle(between first: CGPoint, _ last: CGPoint) -> CGFloat {
        let slope: CGFloat = (last.x - first.x) / (last.y - first.y)
        return atan(slope)
    }
    

    ///Translates a list of points so to the origin, (0,0) and then rotates the line proportionally along the y axis to allow comparison along the x co-ordinates
    /// devience from a relative 0 point.
    ///- Parameter points: Points of the line to translate
    ///- Returns: Translated points relative to input
    private func translate(points: [CGPoint]) -> [CGPoint] {
        guard let first = points.first, let last = points.last, first != last else { fatalError() }
        
        let translation = CGAffineTransform(translationX: -first.x, y: -first.y)
        let rotation = CGAffineTransform(rotationAngle: rotationAngle(between: first, last))
        
        return points.map{ $0.applying(translation).applying(rotation) }
    }

}
