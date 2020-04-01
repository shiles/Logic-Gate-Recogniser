//
//  TriangleTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 06/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class TriangleTests: XCTestCase {

    func testTriangleArea() {
        // Given
        let triangle = Triangle(a: CGPoint(x: 4, y: 0), b: CGPoint(x: 7, y: 2), c: CGPoint(x: 2, y: 3))
        
        // When
        let area = triangle.area
        
        // Then
        XCTAssertEqual(area, (13.0/2))
    }
    
    func testTriangleAreaFromPoints() {
        // Given
        let a = CGPoint(x: 4, y: 0)
        let b = CGPoint(x: 7, y: 2)
        let c = CGPoint(x: 2, y: 3)
        
        // When
        let area = Triangle.area(a: a, b: b, c: c)
        
        // Then
        XCTAssertEqual(area, (13.0/2))
    }

    func testTriangleZeroInitialiser() {
        // Given
        let zero = Triangle.zero
        
        // Then
        XCTAssertEqual(zero.a, CGPoint.zero)
        XCTAssertEqual(zero.b, CGPoint.zero)
        XCTAssertEqual(zero.c, CGPoint.zero)
    }
}
