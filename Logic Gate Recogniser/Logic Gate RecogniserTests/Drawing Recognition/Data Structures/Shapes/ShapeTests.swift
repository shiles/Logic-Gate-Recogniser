//
//  ShapeTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ShapeTests: XCTestCase {

    func testShapeBoundingBox() {
        // Given
        let hull = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        let shape = Shape(type: .rectangle, convexHull: hull)
        
        // When
        let boundingBox = shape.boundingBox
        
        // Then
        XCTAssertEqual(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)), boundingBox)
    }
    
    func testShapeInflatedBoundingBox() {
        // Given
        let hull = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        let shape = Shape(type: .rectangle, convexHull: hull)
        
        // When
        let inflated = shape.inflatedBoundingBox
        
        // Then
        XCTAssertEqual(CGRect(origin: CGPoint(x: -1.9999999999999996, y: -1.9999999999999996), size: CGSize(width: 14, height: 14)), inflated)
    }

}
