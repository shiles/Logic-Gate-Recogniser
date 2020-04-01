//
//  ShapeAnalyserTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class ShapeAnalyserTests: XCTestCase {

    let shapeAnalyser = ShapeAnalyser()
    
    func testSmallestAreaBoundingBox() {
        // Given
        let hull = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        
        // When
        let boundingBox = shapeAnalyser.boundingBox(using: hull)
        
        // Then
        XCTAssertNotNil(boundingBox)
    }
    
    func testLargestAreaTriangleTwoPoints() {
        // Given
        let hull = [CGPoint.zero, CGPoint.zero]
    
        // When
        let triangle = shapeAnalyser.largestAreaTriangle(using: hull)
        
        // Then
        XCTAssertNil(triangle)
    }
    
    func testLargestAreaTriangle() {
        // Given
        let hull = [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 1)]
        
        // When
        let triangle = shapeAnalyser.largestAreaTriangle(using: hull)
        
        // Then
        XCTAssertNotNil(triangle)
        XCTAssertEqual(triangle?.a, CGPoint(x: 0, y: 1))
        XCTAssertEqual(triangle?.b, CGPoint(x: 1, y: 0))
        XCTAssertEqual(triangle?.c, CGPoint(x: 2, y: 1))
        XCTAssertEqual(triangle?.area, 1.0)
    }
    
    func testConvexHullTwoPoints() {
        // Given
        let stroke = [CGPoint.zero, CGPoint.zero]

        // When
        let hull = shapeAnalyser.convexHull(of: stroke)

        // Then
        XCTAssertNil(hull)
    }
       
    func testConvexHull() {
        // Given
        let stroke = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 5), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
        
        let cHull = [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 0), CGPoint(x: 10, y: 10), CGPoint(x: 0, y: 10)]
        
        // When
        let hull = shapeAnalyser.convexHull(of: stroke)
        
        // Then
        XCTAssertNotNil(hull)
        XCTAssertEqual(hull, cHull)
    }
    
    
}
