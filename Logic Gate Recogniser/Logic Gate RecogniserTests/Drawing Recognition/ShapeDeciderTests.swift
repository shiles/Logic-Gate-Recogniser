//
//  ShapeDeciderTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ShapeDeciderTests: XCTestCase {
    
    let sut = ShapeDecider()
    
    func testCircle() {
        // Given
        let shapeAttributes = buildShapeAttributes(tr: 10, tar: 0, rpr: 0)
        
        // When
        let shape = sut.findShape(for: shapeAttributes)
        
        // Then
        XCTAssertEqual(shape.type, ShapeType.Circle)
    }
    
    func testLine() {
        // Given
        let shapeAttributes = buildShapeAttributes(tr: 110, tar: 0, rpr: 0)
        
        // When
        let shape = sut.findShape(for: shapeAttributes)
        
        // Then
        XCTAssertEqual(shape.type, ShapeType.Line)
    }
    
    func testTriangle() {
        // Given
        let shapeAttributes = buildShapeAttributes(tr: 80, tar: 0.80, rpr: 0)

        // When
        let shape = sut.findShape(for: shapeAttributes)

        // Then
        XCTAssertEqual(shape.type, ShapeType.Triangle)
    }
    
    func testRectangle() {
        // Given
        let shapeAttributes = buildShapeAttributes(tr: 80, tar: 0.60, rpr: 0.90)

        // When
        let shape = sut.findShape(for: shapeAttributes)

        // Then
        XCTAssertEqual(shape.type, ShapeType.Rectangle)
    }
    
    func testUnknown() {
        // Given
        let shapeAttributes = buildShapeAttributes(tr: 80, tar: 0.60, rpr: 0.80)

        // When
        let shape = sut.findShape(for: shapeAttributes)

        // Then
        XCTAssertEqual(shape.type, ShapeType.Unknown)
    }
    
    private func buildShapeAttributes(tr: CGFloat, tar: CGFloat, rpr: CGFloat) -> ShapeAttributes {
        return ShapeAttributes(convexHull: [], thinnessRatio: tr,
                                triangleAreaRatio: tar,
                                rectanglePerimeterRatio: rpr)
    }

}
