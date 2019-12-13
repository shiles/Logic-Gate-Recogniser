//
//  CGVector+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class CGVector_ExtensionsTests: XCTestCase {

    func testNormalisedVectorLength() {
        // Given
        let vector = CGVector(dx: 1, dy: 1)
        
        // When
        let nrml = vector.normalized()
        
        // Then
        XCTAssertEqual(nrml, CGVector(dx: 0.7071067811865475, dy: 0.7071067811865475))
    }
    
    func testNormalisedVectorNoLength() {
        // Given
        let vector = CGVector(dx: 0, dy: 0)
        
        // When
        let nrml = vector.normalized()
        
        // Then
        XCTAssertEqual(nrml, CGVector.zero)
    }
    
    func testToPoint() {
        // Given
        let vector = CGVector(dx: 1, dy: 1)
        
        // When
        let point = vector.toPoint()
        
        // Then
        XCTAssertEqual(point, CGPoint(x: 1, y: 1))
    }
    
    func testVectorDevision() {
        // Given
        let vector = CGVector(dx: 10, dy: 10)
       
        // When
        let div = vector / 10.0
        
        // Then
        XCTAssertEqual(div, CGVector(dx: 1, dy: 1))
    }
    
    func testVectorSubtraction() {
        // Given
        let vect1 = CGVector(dx: 2, dy: 2)
        let vect2 = CGVector(dx: 1, dy: 1)
        
        // When
        let result = vect1 - vect2
        
        // Then
        XCTAssertEqual(result, CGVector(dx: 1, dy: 1))
    }
}
