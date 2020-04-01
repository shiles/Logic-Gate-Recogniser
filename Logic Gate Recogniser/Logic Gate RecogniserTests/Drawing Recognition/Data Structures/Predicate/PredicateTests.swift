//
//  PredicateTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class PredicateTests: XCTestCase {

    // MARK: - Shape Tests
    
    func testIsLineWithLine() {
        // Given
        let list = [Shape(type: .line, convexHull: [])]
        
        // When
        let hasLine = list.has(matching: .isLine)
        
        // Then
        XCTAssertTrue(hasLine)
    }
    
    func testIsLineWithCurvedLine() {
        // Given
        let list = [Shape(type: .curvedLine, convexHull: [])]
        
        // When
        let hasLine = list.has(matching: .isLine)
        
        // Then
        XCTAssertTrue(hasLine)
    }
    
    func testIsLineWithStraightTriangle() {
        // Given
        let list = [Shape(type: .straightTriangle, convexHull: [])]
        
        // When
        let hasTriangle = list.has(matching: .isTriangle)
        
        // Then
        XCTAssertTrue(hasTriangle)
    }
    
    func testIsLineWithCurvedTriangle() {
        // Given
        let list = [Shape(type: .curvedTriangle, convexHull: [])]
        
        // When
        let hasTriangle = list.has(matching: .isTriangle)
        
        // Then
        XCTAssertTrue(hasTriangle)
    }
        
    func testIsLineWithNoTriangle() {
        // Given
        let list = [Shape(type: .line, convexHull: [])]
        
        // When
        let hasTriangle = list.has(matching: .isTriangle)
        
        // Then
        XCTAssertFalse(hasTriangle)
    }
    
    // MARK: - GateType Tests
    
    func testContainsCircleWithCircle() {
        // Given
        let list = [GateType.not]
        
        // When
        let hasCircle = list.has(matching: .containsCircle)
        
        // Then
        XCTAssertTrue(hasCircle)
    }
    
    func testContainsCircleWithNoCircle() {
        // Given
        let list = [GateType.or]
        
        // When
        let hasCircle = list.has(matching: .containsCircle)
        
        // Then
        XCTAssertFalse(hasCircle)
    }
    
    func testNotContainsCircleWithCircle() {
       // Given
       let list = [GateType.not]
       
       // When
       let hasCircle = list.has(matching: .notContainsCircle)
       
       // Then
       XCTAssertFalse(hasCircle)
   }
       
    func testNotContainsCircleWithNoCircle() {
        // Given
        let list = [GateType.or]

        // When
        let hasCircle = list.has(matching: .notContainsCircle)

        // Then
        XCTAssertTrue(hasCircle)
    }

    func testContainsTriangleWithTriangle() {
         // Given
         let list = [GateType.not]
         
         // When
         let hasTriangle = list.has(matching: .containsTriangle)
         
         // Then
         XCTAssertTrue(hasTriangle)
     }
    
    func testContainsTriangleWithNoTriangle() {
        // Given
        let list = [GateType.and]
        
        // When
        let hasTriangle = list.has(matching: .containsTriangle)
        
        // Then
        XCTAssertFalse(hasTriangle)
    }
    
    func testNotContainsCurvedTriangleWithCurvedTriangle() {
        // Given
        let list = [GateType.or]
        
        // When
        let hasTriangle = list.has(matching: .notContainsCurvedTriangle)
        
        // Then
        XCTAssertFalse(hasTriangle)
    }
    
    func testNotContainsCurvedTriangleWithNoCurvedTriangle() {
        // Given
        let list = [GateType.not]
        
        // When
        let hasTriangle = list.has(matching: .notContainsCurvedTriangle)
        
        // Then
        XCTAssertTrue(hasTriangle)
    }
    
    func testNotContainsStraightTriangleWithNoStraightTriangle() {
        // Given
        let list = [GateType.or]
        
        // When
        let hasTriangle = list.has(matching: .notContainsStraightTriangle)
        
        // Then
        XCTAssertTrue(hasTriangle)
    }
    
    func testNotContainsStraightTrinaglewithStraightTriangle() {
        // Given
        let list = [GateType.not]
        
        // When
        let hasTriangle = list.has(matching: .notContainsStraightTriangle)
        
        // Then
        XCTAssertFalse(hasTriangle)
    }
    
    func testContainsLineWithLine() {
        // Given
        let list = [GateType.xor]
        
        // When
        let hasLine = list.has(matching: .containsLine)
        
        // Then
        XCTAssertTrue(hasLine)
    }
    
    func testContainsLineWithNoLine() {
        // Given
        let list = [GateType.not]
        
        // When
        let hasLine = list.has(matching: .containsLine)
        
        // Then
        XCTAssertFalse(hasLine)
    }
    
    func testNotContainsLineWithNoLine() {
        // Given
        let list = [GateType.or]
        
        // When
        let hasLine = list.has(matching: .notContainsLine)
        
        // Then
        XCTAssertTrue(hasLine)
    }
    
    func testNotContainsLineWithLine() {
        // Given
        let list = [GateType.xor]
        
        // When
        let hasLine = list.has(matching: .notContainsLine)
        
        // Then
        XCTAssertFalse(hasLine)
    }
    
    // MARK: - Gate Tests
    
    func testIsSingleInputNotGate() {
        // Given
        let not = Not(boundingBox: .zero)
        
        // When
        let isSingleInput = not.has(matching: .isSingleInput)
        
        // Then
        XCTAssertTrue(isSingleInput)
    }
    
    func testIsSingleInputOuputGate() {
        // Given
        let output = Output(boundingBox: .zero)
        
        // When
        let isSingleInput = output.has(matching: .isSingleInput)
        
        // Then
        XCTAssertTrue(isSingleInput)
    }
    
    func testIsSingleInputOtherGate() {
        // Given
        let and = And(boundingBox: .zero)
        
        // When
        let isSingleInput = and.has(matching: .isSingleInput)
        
        // Then
        XCTAssertFalse(isSingleInput)
    }
    
    func testIsNoInputInputGate() {
        // Given
        let input = Input(boundingBox: .zero)
        
        // When
        let isSingleInput = input.has(matching: .isNoInput)
        
        // Then
        XCTAssertTrue(isSingleInput)
    }
    
    func testIsNoInputOtherGate() {
        // Given
        let and = And(boundingBox: .zero)
        
        // When
        let isSingleInput = and.has(matching: .isNoInput)
        
        // Then
        XCTAssertFalse(isSingleInput)
    }
}
