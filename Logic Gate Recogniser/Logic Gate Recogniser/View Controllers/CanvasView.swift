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
    
    private let drawingRecogniser = ShapeRecogniser()
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
    
//        guard let hull = recogniser.convexHull(of: points) else { points = []; return}
//        drawConvexHull(convexHull: hull)
//
//        guard let triangle = recogniser.largestAreaTriangle(using: hull) else { points = []; return}
//        drawTriangle(triangle: triangle)
//
//        let minRect = recogniser.boundingBox(using: hull)
//        drawCorners(boundingBox: minRect)
        
        drawingRecogniser.recogniseShape(from: points)
        points = []
        
        drawingRecogniser.recognisedShapes.forEach {
            let box = $0.inflatedBoundingBox
            let list = [CGPoint(x: box.minX, y: box.minY), CGPoint(x: box.minX, y: box.maxY),
                        CGPoint(x: box.maxX, y: box.maxY), CGPoint(x: box.maxX, y: box.minY)]
            drawConvexHull(convexHull: list, colour: .blue)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.drawingRecogniser.combineShapes()
        }
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
    
    func drawRecognisedLine(line: Line, colour: UIColor = UIColor(hue: drand48())) {
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
    
    func drawConvexHull(convexHull: ConvexHull, colour: UIColor = UIColor.red) {
        if convexHull.isEmpty { return }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        // Draw previous image into context
        drawingImage?.draw(in: bounds)
        
        // Line setup
        context.setLineCap(.round)
        context.setLineWidth(6.0)
        context.setStrokeColor(colour.cgColor)

        // Add lines
        context.move(to: convexHull.first!)
        convexHull.forEach { context.addLine(to: $0) }
        context.addLine(to: convexHull.first!)
        
        // Draw line
        context.strokePath()

        // Update real image
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func drawTriangle(triangle: Triangle, colour: UIColor = UIColor.blue) {        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        // Draw previous image into context
        drawingImage?.draw(in: bounds)
        
        // Line setup
        context.setLineCap(.round)
        context.setLineWidth(6.0)
        context.setStrokeColor(colour.cgColor)

        // Add lines
        context.move(to: triangle.a)
        context.addLine(to: triangle.b)
        context.addLine(to: triangle.c)
        context.addLine(to: triangle.a)
        
        // Draw line
        context.strokePath()

        // Update real image
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func drawCorners(boundingBox: BoundingBox, colour: UIColor = UIColor.green) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!

        // Draw previous image into context
        drawingImage?.draw(in: bounds)
        
        // Line setup
        context.setLineCap(.round)
        context.setLineWidth(6.0)
        context.setStrokeColor(colour.cgColor)

        let cornerPoints = boundingBox.cornerPoints
        
        // Add lines
        context.move(to: cornerPoints.p1)
        context.addLine(to: cornerPoints.p2)
        context.addLine(to: cornerPoints.p3)
        context.addLine(to: cornerPoints.p4)
        context.addLine(to: cornerPoints.p1)
        
        // Draw line
        context.strokePath()

        // Update real image
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
