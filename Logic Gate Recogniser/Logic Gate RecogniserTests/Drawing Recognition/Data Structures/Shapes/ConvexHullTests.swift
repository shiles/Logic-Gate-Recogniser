//
//  ConvexHullTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ConvexHullTests: XCTestCase {

    func testConvexHullEdges() {
        // Given
        let hull = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        let expected = [CGVector(dx: 0, dy: 10), CGVector(dx: 10, dy: 0), CGVector(dx: 0, dy: -10), CGVector(dx: -10, dy: 0)]
        
        // When
        let edges = hull.edges
        
        // Then
        XCTAssertEqual(expected, edges)
    }
    
    func testConvexHullPerimeterWithPoints() {
        // Given
        let hull = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        
        // When
        let perimeter = hull.perimeter
        
        // Then
        XCTAssertNotNil(perimeter)
        XCTAssertEqual(40.0, hull.perimeter)
    }
    
    func testConvexHullPerimeterNoPoints() {
        // Given
        let hull: ConvexHull = []
        
        // When
        let perimeter = hull.perimeter
        
        // Then
        XCTAssertNil(perimeter)
    }

}
