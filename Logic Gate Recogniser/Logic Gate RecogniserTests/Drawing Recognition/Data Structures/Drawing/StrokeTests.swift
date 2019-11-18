//
//  StrokeTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class StrokeTests: XCTestCase {

    func testStrokeNoPoints() {
        // Given
        let points: Stroke = []
        
        // When
        let perimeterLength = points.length
        
        // Then
        XCTAssertEqual(0, perimeterLength)
    }
    
    func testStrokeOnePoint() {
        // Given
        let points = [CGPoint(x: 0, y: 0)]
        
        // When
        let perimeterLength = points.length
        
        // Then
        XCTAssertEqual(0, perimeterLength)
    }
    
    func testSrokeWithPoints() {
        // Given
        let points = [CGPoint(x: 15, y: 20), CGPoint(x: 35, y: 5)]
        
        // When
        let perimeterLength = points.length
        
        // Then
        XCTAssertEqual(25, perimeterLength)
    }
    
}
