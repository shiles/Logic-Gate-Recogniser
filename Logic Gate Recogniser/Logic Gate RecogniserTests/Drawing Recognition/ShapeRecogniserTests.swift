//
//  ShapeRecogniserTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ShapeRecogniserTests: XCTestCase {

    let shapeRecogniser = ShapeRecogniser()
    
    // MARK: - Recognise Basic Shapes
    
    func testRecogniseLine() {
        // Given
        let stroke = StrokeBuilder.straightLine
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .line)
    }
    
    func testRecogniseCurvedLine() {
        // Given
        let stroke = StrokeBuilder.curvedLine
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .curvedLine)
    }
    
    func testRecogniseCurvedIncompleteTriangle() {
        // Given
        let stroke = StrokeBuilder.incompleteTriangle
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .incompleteTriangle)
    }
    
    func testRecogniseCurvedStraightTriangle() {
        // Given
        let stroke = StrokeBuilder.straightTriangle
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .straightTriangle)
    }

    func testRecogniseCurvedCurvedTriangle() {
        // Given
        let stroke = StrokeBuilder.curvedTriangle
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .curvedTriangle)
    }
    
    func testRecogniseRectangle() {
        // Given
        let stroke = StrokeBuilder.rectangle
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .rectangle)
    }
    
    func testRecogniserCircle() {
        // Given
        let stroke = StrokeBuilder.circle
    
        // When
        let adjacentShapes = shapeRecogniser.recogniseShape(from: stroke, into: [])
        
        // Then
        XCTAssertEqual(adjacentShapes.first?.first?.type, .circle)
    }
    
    func testAdjacentShapesTogether() {
        // Given
        let lineA = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10)]
        let lineB = [CGPoint(x: 0, y: 5), CGPoint(x: 10, y: 5)]
        
        // When
        var adjacentShapes = shapeRecogniser.recogniseShape(from: lineA, into: [])
        adjacentShapes = shapeRecogniser.recogniseShape(from: lineB, into: adjacentShapes)
        
        // Then
        XCTAssertEqual(adjacentShapes.count, 1)
        XCTAssertEqual(adjacentShapes.first?.count, 2)
    }
    
    // MARK: - Perform Analysis Tests
    
    func testCombineLineAndTriagleToStraightTriangle() {
        // Given
        let line = ShapeBuilder.straightTriangle
        let triangle = ShapeBuilder.incompleteTriangle
        let adjacentShapes = [[line, triangle]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertEqual(result.first?.first?.type, .straightTriangle)
    }
    
    func testCombineCurvedLineAndTriagleToCurvedTriangle() {
        // Given
        let line = ShapeBuilder.curvedLine
        let triangle = ShapeBuilder.incompleteTriangle
        let adjacentShapes = [[line, triangle]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertTrue(result.isEmpty) // Because a OR gate was found
    }
    
    func testCombineStraightLinesToStraightTriangle() {
        // Given
        let line = ShapeBuilder.straightTriangle
        let adjacentShapes = [[line, line, line]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertEqual(result.first?.first?.type, .straightTriangle)
    }
    
    func testCombineCurvedLinesToCurvedTriangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let curvedLine = ShapeBuilder.curvedLine
        let adjacentShapes = [[line, line, curvedLine]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertTrue(result.isEmpty) // Because a OR gate was found
    }
    
    func testCombineLinesToRectangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let curvedLine = ShapeBuilder.curvedLine
        let adjacentShapes = [[line,curvedLine]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertTrue(result.isEmpty) // Because a AND gate was found
    }
    
    func testCombineShapesToGate() {
        // Given
        let triangle = ShapeBuilder.straightTriangle
        let circle = ShapeBuilder.circle
        let adjacentShapes = [[triangle, circle]]
        
        // When
        let result = shapeRecogniser.performAnalysis(in: adjacentShapes)
        
        // Then
        XCTAssertTrue(result.isEmpty) // Because a NOT gate was found
    }
    
    // MARK: - Erase Shapes Tests
    
    func testEraseShapeNonIntersectingStroke() {
        // Given
        let erasorStroke = [CGPoint(x: 0, y: 5), CGPoint(x: 5, y: 5)]
        let adjacentShapes = [[Shape(type: .line, convexHull: [CGPoint(x: 10, y: 10), CGPoint(x: 20, y: 10)])]]
        
        // When
        let rslt = shapeRecogniser.eraseShapes(eraserStroke: erasorStroke, in: adjacentShapes)
        
        // Then
        XCTAssertEqual(rslt, adjacentShapes)
        XCTAssertEqual(rslt.count, 1)
    }
    
    func testEraseShapeIntersectingStroke() {
        // Given
        let erasorStroke = [CGPoint(x: 0, y: 5), CGPoint(x: 5, y: 5)]
        let shape = Shape(type: .line, convexHull: [CGPoint(x: 2.5, y: 0), CGPoint(x: 2.5, y: 10)], components: [[CGPoint(x: 2.5, y: 0), CGPoint(x: 2.5, y: 10)]])
        let adjacentShapes = [[shape]]
        
        // When
        let rslt = shapeRecogniser.eraseShapes(eraserStroke: erasorStroke, in: adjacentShapes)
        
        // Then
        XCTAssertTrue(rslt.isEmpty)
    }
}
