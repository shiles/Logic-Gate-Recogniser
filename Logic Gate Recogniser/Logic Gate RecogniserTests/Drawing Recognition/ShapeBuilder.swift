//
//  ShapeBuilder.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
@testable import Recogniser

class ShapeBuilder {
    
    static var straightLine: Shape {
        Shape(type: .line(type: .straight), convexHull: StrokeBuilder.straightTriangle, components: [StrokeBuilder.straightTriangle])
    }
    
    static var curvedLine: Shape {
        Shape(type: .line(type: .curved), convexHull: StrokeBuilder.curvedLine, components: [StrokeBuilder.curvedLine])
    }
    
    static var incompleteTriangle: Shape {
        Shape(type: .triangle(type: .incomplete), convexHull: StrokeBuilder.incompleteTriangle, components: [StrokeBuilder.incompleteTriangle])
    }
    
    static var straightTriangle: Shape {
        Shape(type: .triangle(type: .straight), convexHull: StrokeBuilder.straightTriangle, components: [StrokeBuilder.straightTriangle])
    }
    
    static var curvedTriangle: Shape {
        Shape(type: .triangle(type: .curved), convexHull: StrokeBuilder.curvedTriangle, components: [StrokeBuilder.curvedTriangle])
    }
    
    static var rectangle: Shape {
        Shape(type: .rectangle, convexHull: StrokeBuilder.rectangle, components: [StrokeBuilder.rectangle])
    }
    
    static var circle: Shape {
        Shape(type: .circle, convexHull: StrokeBuilder.circle, components: [StrokeBuilder.circle])
    }
}
