//
//  CanvasView.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 25/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class CanvasView: UIImageView {
    
    let canvasViewModel = CanvasViewModel()
    
    // Tool Settings
    private var defaultLineWidth: CGFloat = 10
    private var drawColor: UIColor = .label
    
    // Tool Selection
    var tool: DrawingTools = .pen {
        didSet {
            switch tool {
                case .pen: drawColor = .label
                case .erasor: drawColor = .systemBackground
            }
        }
    }
    
    // Predictive Drawing
    private var drawingImage: UIImage?
    private var points: [CGPoint] = []
    
    // MARK: Touch Event Handlers
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasViewModel.strokeMoved()
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
            self.drawTouchEvent(context: context, touch: touch)
        }
        
        // Draws a dispsoable image using predicted data from apple
        self.drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if let predictedTouches = event?.predictedTouches(for: touch) {
            for touch in predictedTouches {
                self.drawTouchEvent(context: context, touch: touch)
            }
        }

        // Update real image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        image = drawingImage
        canvasViewModel.strokeFinished(stroke: points, tool: tool)
        points = []
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        image = drawingImage
    }
    
    // MARK: Drawing Code

    ///Draw the touch event on the canvas
    ///- Parameter context: Context to draw the event too
    ///- Parameter touch: Touch event to draw
    private func drawTouchEvent(context: CGContext, touch: UITouch) {
        self.drawStroke(context: context, stroke: [touch.previousLocation(in: self), touch.location(in: self)])
    }
    
    ///Draws a stroke onto the canvas that has occured.
    ///- Parameter context: Context which to draw it in
    ///- Parameter stroke: Stroke to draw,
    private func drawStroke(context: CGContext, stroke: Stroke, colour: UIColor? = nil) {
        // Configure line
        if let colour = colour {
            colour.setStroke()
        } else {
            drawColor.setStroke()
        }
        context.setLineWidth(defaultLineWidth)
        context.setLineCap(.round)
        
        // Draw Lines
        context.move(to: stroke.first!)
        (1...stroke.lastIndex).forEach { context.addLine(to: stroke[$0]) }
        context.strokePath()
    }
}

extension CanvasView: CanvasDrawer {
    
    func updateCanvas() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw the gates that have been found
        canvasViewModel.gates.forEach { gate in
            gate.draw(with: context)
        }
        
        // Draw the shapes that aren't recognised
        for shapes in canvasViewModel.adjacentShapes {
            shapes.map(\.components).flatMap { $0 }.forEach { stroke in
                self.drawStroke(context: context, stroke: stroke, colour: .label)
            }
        }
        
        drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}
