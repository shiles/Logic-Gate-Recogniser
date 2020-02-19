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
    
    func testBoundingBoxNoPoints() {
        // Given
        let points: Stroke = []
        
        // When
        let boundingBox = points.boundingBox
        
        // Then
        XCTAssertEqual(CGRect(), boundingBox)
    }
    
    func testBoundingBoxOnePoint() {
        // Given
        let points: Stroke = [CGPoint(x: 0, y: 0)]
        
        // When
        let boundingBox = points.boundingBox
        
        // Then
        XCTAssertEqual(CGRect(), boundingBox)
    }
    
    func testBoudingBoxWithPoints() {
        // Given
        let points: Stroke = [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 10)]
        
        // When
        let boundingBox = points.boundingBox
        
        // Then
        XCTAssertEqual(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)), boundingBox)
    }
    
    func testIntersectsNoIntersection() {
        // Given
        let points: Stroke = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1)]
        let target: Stroke = [CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10)]
        
        // When
        let doesIntersect = target.interesects(with: points)
        
        // Then
        XCTAssertFalse(doesIntersect)
    }
    
    func testIntersectsIntersection() {
        // Given
        let points: Stroke = [CGPoint(x: 5, y: 5), CGPoint(x: 5, y: 15)]
        let target: Stroke = [CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10)]
        
        // When
        let doesIntersect = target.interesects(with: points)
        
        // Then
        XCTAssertTrue(doesIntersect)
    }
}
