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

    private let allowedLineDevience: CGFloat = 5
    private let angleForCorner: CGFloat = 0.78539846254493
    
    func recogniseShape(points: [CGPoint]) -> [Line] {
        let orderedPoints = points.reversed().map { $0 }
        let straitLines = recogniseStraitLines(points: orderedPoints)

        for i in 0...straitLines.count {
            guard let first = straitLines[safe: i], let second = straitLines[safe: i+1] else { break }
            let angle = angleBetwen(between: first, second)
            
            
            
            print(angle.toDegrees())
        }
        
        return straitLines
    }
    
    private func angleBetwen(between first: Line, _ second: Line) -> Angle {
        let missingSide = Line(startPoint: second.endPoint, endPoint: first.startPoint)
        let a = missingSide.length
        let b = first.length
        let c = second.length
        
        return acos((b.squared() + c.squared() - a.squared()) / (2.0 * b * c))
    }
    
    private func recogniseStraitLines(points: [CGPoint]) -> [Line] {
        if recogniseStraitLine(points: points) {
            return [ Line(startPoint: points.last!, endPoint:  points.first!) ]
        }
        
        let split = points.split()
        return recogniseStraitLines(points: split.right) + recogniseStraitLines(points: split.left)
    }
    
    private func recogniseStraitLine(points: [CGPoint]) -> Bool {
        let xCoords = translate(points: points).map { $0.x }
        let rms = rootMeanSqaure(points: xCoords)
        return rms < allowedLineDevience
    }
    
    private func rotationAngle(between first: CGPoint, _ last: CGPoint) -> CGFloat {
        // Need to consider when x and when y depending on the dirrection of travel
        let slope: CGFloat = (last.x - first.x) / (last.y - first.y)
        return atan(slope)
    }
    
    private func translate(points: [CGPoint]) -> [CGPoint] {
        guard let first = points.first, let last = points.last, first != last else { fatalError() }
        
        let translation = CGAffineTransform(translationX: -first.x, y: -first.y)
        let rotation = CGAffineTransform(rotationAngle: rotationAngle(between: first, last))
        
        return points.map{ $0.applying(translation).applying(rotation) }
    }
    
    private func rootMeanSqaure(points: [CGFloat]) -> CGFloat {
        return (points.map { $0.squared() }.reduce(0, +) / CGFloat(points.count)).squareRoot()
    }

}
