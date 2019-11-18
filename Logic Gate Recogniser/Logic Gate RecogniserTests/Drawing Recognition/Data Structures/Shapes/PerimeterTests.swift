//
//  PerimeterTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class PerimeterTests: XCTestCase {

    func testPerimeterLengthNoPoints() {
        // Given
        let points: [CGPoint] = []
        
        // When
        let perimeterLength = Perimeter.perimeter(of: points)
        
        // Then
        XCTAssertNil(perimeterLength)
    }
    
    func testPerimeterLengthLessThanThreePoints() {
        // Given
        let points = [CGPoint(x: 15, y: 20), CGPoint(x: 35, y: 5)]
        
        // When
        let perimeterLength = Perimeter.perimeter(of: points)
        
        // Then
        XCTAssertNil(perimeterLength)
    }
    
    func testPerimeterLengthRectangle() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 100), CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 0)]
        
        // When
        let perimeterLength = Perimeter.perimeter(of: points)
       
        // Then
        XCTAssertEqual(400, perimeterLength)
    }

}
