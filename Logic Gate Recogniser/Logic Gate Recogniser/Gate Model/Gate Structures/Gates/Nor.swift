//
//  Nor.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class Nor: Gate {
    var description: String { "Nor" }
    var boundingBox: CGRect
    var inputs: [Gate] = []
    var output: Bool = false
    var hasChanged: Bool = false
    
    var path: UIBezierPath {
        let path = UIBezierPath()
        
        // Draw Triangle
        path.move(to: CGPoint(x: 0.1, y: 0.2))
        path.addCurve(to: CGPoint(x: 0.1, y: 0.8), controlPoint1: CGPoint(x: 0.25, y: 0.4), controlPoint2: CGPoint(x: 0.25, y: 0.6))
        path.addCurve(to: CGPoint(x: 0.7, y: 0.5), controlPoint1: CGPoint(x: 0.2, y: 0.85), controlPoint2: CGPoint(x: 0.6, y: 0.6))
        path.addCurve(to: CGPoint(x: 0.1, y: 0.2), controlPoint1: CGPoint(x: 0.6, y: 0.35), controlPoint2: CGPoint(x: 0.2, y: 0.15))
        
        // Draw Circle
        path.move(to: CGPoint(x: 0.9, y: 0.5))
        path.addArc(withCenter: CGPoint(x: 0.8, y: 0.5), radius: 0.1, startAngle: 0.0, endAngle: .pi*2, clockwise: true)
        
        //Draw Inputs
        path.move(to: CGPoint(x: 0, y: 0.35))
        path.addLine(to: CGPoint(x: 0.182, y: 0.35))
        path.move(to: CGPoint(x: 0, y: 0.65))
        path.addLine(to: CGPoint(x: 0.182, y: 0.65))
        
        // Draw Ouput
        path.move(to: CGPoint(x: 0.9, y: 0.5))
        path.addLine(to: CGPoint(x: 1, y: 0.5))

        path.scaleToFit(boundingBox)
        return path
    }
    
    init(boundingBox: CGRect) {
        self.boundingBox = boundingBox.squared()
    }

    func draw(with context: CGContext) {
        UIGraphicsPushContext(context)
        let drawable = path
        drawable.setDefaultAttributes()
        drawable.stroke()
        UIGraphicsPopContext()
    }
    
    func run() {
        guard let first = inputs.first?.output, let second = inputs.second?.output else {
            NotificationCenter.default.post(name: .endSimulation, object: nil)
            return
        }
        
        let val = !(first || second)
        hasChanged = output != val
        output = val
    }
}
