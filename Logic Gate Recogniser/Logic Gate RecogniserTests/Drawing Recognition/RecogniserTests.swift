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

    let recogniser = Recogniser()
    
    func testExample() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 50), CGPoint(x: 0, y: 100), CGPoint(x: 50, y: 100),
            CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 50), CGPoint(x: 50, y: 50)]
        
        // When
        let convexHull = recogniser.convexHull(of: points)
        
        // Then
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
        let m1 = Matrix<Int>(from: [1,2])
        let m2 = Matrix<Int>(from: [[10,10], [100,100]])
        let r = m1.strassenMatrixMultiply(by: m2)
        
        
    }


}
