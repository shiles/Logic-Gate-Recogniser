//
//  CanvasView.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 25/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

enum DrawingTools {
    case pen
    case erasor
}

class CanvasView: UIImageView {
    
    private let recogniser = DrawingRecogniser()
    private var recognisedLines: [Line] = []
    
    // Tool Settings
    private var defaultLineWidth: CGFloat = 10
    private var drawColor: UIColor = .label
    
    // Tool Selection
    var tool: DrawingTools? {
        didSet {
            switch tool {
                case .pen:
                    drawColor = .label
                    defaultLineWidth = 10
                case .erasor:
                    drawColor = .systemBackground
                    defaultLineWidth = 30
                case .none: fatalError()
            }
        }
    }
    
    // Predictive Drawing
    private var drawingImage: UIImage?
    private var points: [CGPoint] = []
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        // Draw previous image into context
        drawingImage?.draw(in: bounds)

        // Handles extra touches pencil recognises that screen doesn't on real image
        var touches = [UITouch]()
        
        if let coalescedTouches = event?.coalescedTouches(for: touch) {
            touches = coalescedTouches
        } else {
            touches.append(touch)
        }
        
        for touch in touches {
            points.append(touch.location(in: self))
            self.drawStroke(context: context, touch: touch)
        }
        
        // Draws a dispsoable image using predicted data from apple
        self.drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if let predictedTouches = event?.predictedTouches(for: touch) {
            for touch in predictedTouches {
                self.drawStroke(context: context, touch: touch)
            }
        }

        // Update real image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        image = drawingImage
        
        let debugDraw = recogniser.recogniseShape(points: points)
        
        debugDraw.forEach { line in
             recognisedLines.append(line)
             drawRecognisedLine(line: line)
        }
        
        for i in 0...debugDraw.count {
            guard let first = debugDraw[safe: i], let second = debugDraw[safe: i+1] else { break }
            let line = Line(startPoint: second.endPoint, endPoint: first.startPoint)
            drawRecognisedLine(line: line, colour: UIColor.red)
        }
        
        points = []
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        image = drawingImage
    }
    
    private func drawStroke(context: CGContext, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        // Set color
        drawColor.setStroke()

        // Configure line
        context.setLineWidth(defaultLineWidth)
        context.setLineCap(.round)

        // Set up the points
        context.move(to: CGPoint(x: previousLocation.x, y: previousLocation.y))
        context.addLine(to: CGPoint(x: location.x, y: location.y))
        
        // Draw the stroke
        context.strokePath()
     }
    
    func drawRecognisedLine(line: Line, colour: UIColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        // Draw previous image into context
        drawingImage?.draw(in: bounds)
        
        // Line setup
        context.setLineCap(.round)
        context.setLineWidth(6.0)
        context.setStrokeColor(colour.cgColor)

        // Add lines
        context.move(to: line.startPoint)
        context.addLine(to: line.endPoint)

        // Draw line
        context.strokePath()

        // Update real image
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    
}
