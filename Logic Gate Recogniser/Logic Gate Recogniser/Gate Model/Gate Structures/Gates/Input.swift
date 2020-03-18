//
//  Input.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class Input: Gate {
    var boundingBox: CGRect
    var description: String = ""
    var inputs: [Gate] = []
    var output: Bool = false
    var hasChanged: Bool = false
    
    var path: UIBezierPath {
        let path = UIBezierPath()
            
        //Draw outter box
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 1))
        path.addLine(to: CGPoint(x: 1, y: 1))
        path.addLine(to: CGPoint(x: 1, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        //Draw inner box
        path.move(to: CGPoint(x: 0.1, y: 0.1))
        path.addLine(to: CGPoint(x: 0.1, y: 0.9))
        path.addLine(to: CGPoint(x: 0.9, y: 0.9))
        path.addLine(to: CGPoint(x: 0.9, y: 0.1))
        path.addLine(to: CGPoint(x: 0.1, y: 0.1))
        
        //Conditional on state (1 of 0)
        if output {
            path.move(to: CGPoint(x: 0.5, y: 0.8))
            path.addLine(to: CGPoint(x: 0.5, y: 0.2))
            path.addLine(to: CGPoint(x: 0.4, y: 0.3))
        } else {
            let oval = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: 0.3, y: 0.2), size: CGSize(width: 0.4, height: 0.6)))
            path.append(oval)
        }
        
        path.scaleToFit(boundingBox)
        return path
    }
    
    init(boundingBox: CGRect, initialValue: Bool = false) {
        self.boundingBox = boundingBox
        output = initialValue
    }
    
    func draw(with context: CGContext) {
        UIGraphicsPushContext(context)
        let drawable = path
        drawable.setDefaultAttributes()
        UIColor.red.setStroke()
        drawable.lineWidth = 5
        drawable.stroke()
        UIGraphicsPopContext()
    }
    
    func run() {}
}
