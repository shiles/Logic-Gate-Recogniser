//
//  RecogniserTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 07/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class RecogniserTests: XCTestCase {

    let recogniser = ShapeAnalyser()
    
    func testExample() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 50), CGPoint(x: 0, y: 100), CGPoint(x: 50, y: 100),
            CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 50), CGPoint(x: 50, y: 50)]
        
        // When
        let convexHull = recogniser.convexHull(of: points)
        
        // Then
    }
    
    func testExample2() {
        // Given
        let points = [CGPoint(x: 4, y: 10), CGPoint(x: 9, y: 7), CGPoint(x: 11, y: 2), CGPoint(x: 2, y: 2)]
        
        // When
        let convexHull = recogniser.convexHull(of: points)
        let area = convexHull!.area
        
        
        // Then
        XCTAssertEqual(area, 45.5)
    }
    
    func test2() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 100), CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 0)]
        let convexHull = recogniser.convexHull(of: points)!
        
        // When
        let minBound = recogniser.boundingBox(using: convexHull)
        
        // Then
    }
    
    func test3() {
        // Given
        let points = [CGPoint(x: 445.0, y: 354.0), CGPoint(x: 445.0, y: 363.0),
                      CGPoint(x: 445.0, y: 376.0), CGPoint(x: 445.0, y: 395.0),
                      CGPoint(x: 445.0, y: 432.0), CGPoint(x: 445.0, y: 496.5),
                      CGPoint(x: 456.5, y: 545.5), CGPoint(x: 475.0, y: 580.0),
                      CGPoint(x: 495.5, y: 604.0)]
        
        // When
        let hull = recogniser.convexHull(of: points)
        
    }


}
