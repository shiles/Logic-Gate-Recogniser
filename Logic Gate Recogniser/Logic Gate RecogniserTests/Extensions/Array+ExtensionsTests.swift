//
//  Array+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class Array_ExtensionsTests: XCTestCase {

    // MARK: - Generic Tests
    
    func testLastIndex() {
        // Given
        let array = [1,2,3]
        
        // When
        let index = array.lastIndex
        
        // Then
        XCTAssertEqual(index, array.count-1)
    }
    
    func testSplit() {
        // Given
        let array = [1,2,3,4]
        
        // When
        let (l, r) = array.split()

        // Then
        XCTAssertEqual(l, [1,2,3])
        XCTAssertEqual(r, [3, 4])
    }
    
    func testReplaceLast() {
        // Given
        let array = [1,2,3]
        
        // When
        let modified = array.replaceLast(4)
        
        // Then
        XCTAssertEqual(modified, [1,2,4])
    }
    
    func testCircularAccess() {
        // Given
        let array = [1,2,3]
        
        // When
        let accessed = array[circular: 4]
        
        // Then
        XCTAssertEqual(accessed, Optional(2))
    }
    
    func testCircularAccessEmpty() {
        // Given
        let array: [Int] = []
        
        // When
        let accessed = array[circular: 1]
        
        // Then
        XCTAssertNil(accessed)
    }
    
    func testHasElements() {
        // Given
        let array: [Int] = [1]
        
        // When
        let hasElements = array.hasElements
        
        // Then
        XCTAssertTrue(hasElements)
    }
    
    func testHasElementsEmpty() {
        // Given
        let array: [Int] = []
        
        // When
        let hasElements = array.hasElements
        
        // Then
        XCTAssertFalse(hasElements)
    }
    
    // MARK: - Predicate Tests
    
    func testShapesMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = [Shape(type: .line, convexHull: [])]
        
        // When
        let lines = array.shapes(matching: .isLine)
        
        // Then
        XCTAssertEqual(expected, lines)
    }
    
    func testShapesNotMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = []
        
        // When
        let lines = array.shapes(matching: .isTriangle)
        
        // Then
        XCTAssertEqual(expected, lines)
    }
    
    func testHasMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        
        // When
        let hasPredicate = array.has(matching: .isLine)
        
        // Then
        XCTAssertTrue(hasPredicate)
    }
    
    func testHasNotMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        
        // When
        let hasPredicate = array.has(matching: .isTriangle)
        
        // Then
        XCTAssertFalse(hasPredicate)
    }
    
    func testRemoveMatchPredicate() {
        // Given
        var array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = []
        
        // When
        array.remove(matching: .isLine)
        
        // Then
        XCTAssertEqual(expected, array)
    }
    
    func testRemoveNotMatchPredicate() {
        // Given
        var array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = [Shape(type: .line, convexHull: [])]
        
        // When
        array.remove(matching: .isTriangle)
        
        // Then
        XCTAssertEqual(expected, array)
    }
    
    func testWithOutMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = []
        
        // When
        let lines = array.withOut(matching: .isLine)
        
        // Then
        XCTAssertEqual(expected, lines)
    }
    
    func testWithOutNotMatchPredicate() {
        // Given
        let array: [Shape] = [Shape(type: .line, convexHull: [])]
        let expected: [Shape] = [Shape(type: .line, convexHull: [])]
        
        // When
        let lines = array.withOut(matching: .isTriangle)
        
        // Then
        XCTAssertEqual(expected, lines)
    }
    
    // MARK: - FloatingPoint Tests
    
    func testRootMeanSquared() {
        // Given
        let array: [CGFloat] = [0.8, 1.0, 0.2]
        
        // When
        let rms = array.rootMeanSquared()
        
        // Then
        XCTAssertEqual(rms, 0.7483314773547883)
    }
    
    // MARK: - Hashable Tests

    func testHashable() {
        // Given
        let array: [Int] = [1,1,1,2,2,3,4]
        
        // When
        let unique = array.unique
        
        // Then
        XCTAssertEqual(unique.sorted(), [1,2,3,4])
    }
    
    func testHashableEmpty() {
        // Given
        let array: [Int] = []
        
        // When
        let unique = array.unique
        
        // Then
        XCTAssertEqual(unique, [])
    }
    
    // MARK: - CGPoint Tests

    func testTransposedMatrix() {
        // Given
        let array = [CGPoint(x: 0, y: 1), CGPoint(x: 2, y: 3), CGPoint(x: 4, y: 5)]
        
        // When
        let matrix = array.transposedMatrix
        
        // Then
        let result = Matrix<CGFloat>(from: [[0,2,4],[1,3,5]])
        XCTAssertEqual(matrix.grid, result.grid)
    }
    
    func testTransposedMatrixEmpty() {
        // Given
        let array: [CGPoint] = []
        
        // When
        let matrix = array.transposedMatrix
        
        // Then
        let result = Matrix<CGFloat>(from: [[],[]])
        XCTAssertEqual(matrix.grid, result.grid)
    }
    
    func testRemoveMinPointUniqueY() {
        // Given
        var array = [CGPoint(x: 0, y: 1), CGPoint(x: 2, y: 3), CGPoint(x: 4, y: 5)]
        
        // When
        let minPoint = array.removeMinPoint()
        
        // Then
        XCTAssertEqual(minPoint, CGPoint(x: 0, y: 1))
        XCTAssertEqual(array, [CGPoint(x: 2, y: 3), CGPoint(x: 4, y: 5)])
    }
    
    func testRemoveMinPointNonUniqueY() {
        // Given
        var array = [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 3), CGPoint(x: 4, y: 5)]
        
        // When
        let minPoint = array.removeMinPoint()
        
        // Then
        XCTAssertEqual(minPoint, CGPoint(x: 0, y: 1))
        XCTAssertEqual(array, [CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 3), CGPoint(x: 4, y: 5)])
    }
}
