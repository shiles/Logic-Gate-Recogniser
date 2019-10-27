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

class DrawingRecogniser {

    private let allowedDevience: CGFloat = 10
    
    func recogniseStraitLine(points: [CGPoint]) -> Bool {
        let xCoords = translate(points: points).map { $0.x }
        let rms = rootMeanSqaure(points: xCoords)
        return rms < allowedDevience
    }

    private func rotationAngle(between first: CGPoint, _ last: CGPoint) -> CGFloat{
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
        return (points.map { $0 * $0 }.reduce(0, +) / CGFloat(points.count)).squareRoot()
    }

}
