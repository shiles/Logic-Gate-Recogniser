//
//  ShapeCombinerTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ShapeCombinerTests: XCTestCase {

    let shapeCombiner = ShapeCombiner()

    // MARK: - Shapes to Gates
    
    func testShapesToNot() {
        // Given
        let shapes = [ShapeBuilder.straightTriangle, ShapeBuilder.circle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a NOT gate has been found
    }
    
    func testShapesToOr() {
        // Given
        let shapes = [ShapeBuilder.curvedTriangle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a OR gate has been found
    }
    
    func testShapesToNor() {
        // Given
        let shapes = [ShapeBuilder.curvedTriangle, ShapeBuilder.circle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a NOR gate has been found
    }
    
    func testShapesToAnd() {
        // Given
        let shapes = [ShapeBuilder.rectangle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a AND gate has been found
    }
    
    func testShapesToNand() {
        // Given
        let shapes = [ShapeBuilder.rectangle, ShapeBuilder.circle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a NAND gate has been found
    }
    
    func testShapesToXor() {
        // Given
        let shapes = [ShapeBuilder.curvedLine, ShapeBuilder.curvedTriangle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a XOR gate has been found
    }
    
    func testShapesToXnor() {
        // Given
        let shapes = [ShapeBuilder.curvedLine, ShapeBuilder.curvedTriangle, ShapeBuilder.circle]
        
        // When
        let results = shapeCombiner.combineShapesToGates(shapes: shapes)
        
        // Then
        XCTAssertNil(results) // Because a XNOR gate has been found
    }
    
    // MARK: - Shape Combiners
    
    func testCombineStraightLinesToTriangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let shapes = [line, line, line]
        
        // When
        let results = shapeCombiner.combineToTriangle(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .triangle(type: .straight))
    }
    
    func testCombineCurvedLinesToTriangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let curved = ShapeBuilder.curvedLine
        let shapes = [line, curved, line]
        
        // When
        let results = shapeCombiner.combineToTriangle(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .triangle(type: .curved))
    }

    func testCombineLinesToTriangleWithOtherShapes() {
        // Given
        let line = ShapeBuilder.straightLine
        let curved = ShapeBuilder.curvedLine
        let circle = ShapeBuilder.circle
        let shapes = [line, curved, line, circle]
        
        // When
        let results = shapeCombiner.combineToTriangle(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .circle)
        XCTAssertEqual(results.second?.type, .triangle(type: .curved))
    }
    
    func testCombileLineAndTriangleToStraightTriangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let triangle = ShapeBuilder.incompleteTriangle
        let shapes = [line, triangle]
        
        // When
        let results = shapeCombiner.completeTriangleWithLine(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .triangle(type: .straight))
    }
    
    func testCombileLineAndTriangleToCurvedTriangle() {
        // Given
        let line = ShapeBuilder.curvedLine
        let triangle = ShapeBuilder.incompleteTriangle
        let shapes = [line, triangle]
        
        // When
        let results = shapeCombiner.completeTriangleWithLine(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .triangle(type: .curved))
    }
    
    func testCombileLineAndTriangleToTriangleWithOtherShapes() {
        // Given
        let line = ShapeBuilder.curvedLine
        let triangle = ShapeBuilder.incompleteTriangle
        let circle = ShapeBuilder.circle
        let shapes = [line, triangle, circle]
        
        // When
        let results = shapeCombiner.completeTriangleWithLine(shapes: shapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .circle)
        XCTAssertEqual(results.second?.type, .triangle(type: .curved))
    }
    
    func testLineAndCurvedToRectangle() {
        // Given
        let line = ShapeBuilder.straightLine
        let curvedLine = ShapeBuilder.curvedLine
        let adjacentShapes = [line, curvedLine]
        
        // When
        let results = shapeCombiner.combineToRectangle(shapes: adjacentShapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .rectangle)
    }
    
    func testLineAndCurvedToRectangleWithOtherShapes() {
        // Given
        let line = ShapeBuilder.straightLine
        let curvedLine = ShapeBuilder.curvedLine
        let circle = ShapeBuilder.circle
        let adjacentShapes = [line, curvedLine, circle]
        
        // When
        let results = shapeCombiner.combineToRectangle(shapes: adjacentShapes)
        
        // Then
        XCTAssertEqual(results.first?.type, .circle)
        XCTAssertEqual(results.second?.type, .rectangle)
    }
    
}
