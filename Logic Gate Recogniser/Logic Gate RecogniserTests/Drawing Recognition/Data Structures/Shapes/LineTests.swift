//
//  LineTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class LineTests: XCTestCase {

    func testLineOriginVector() {
        // Given
        let line = Line(startPoint: CGPoint(x: 10, y: 10), endPoint: CGPoint(x: 11, y:11))
        
        // When
        let vector = line.vector
        
        //Then
        XCTAssertEqual(CGVector(dx: 1, dy: 1), vector)
    }
    
    func testLineBoundingBox() {
        // Given
        let line = Line(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 10, y:10))
        
        // When
        let boundingBox = line.boundingBox
        
        // Then
        XCTAssertEqual(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)), boundingBox)
    }
    
    func testLineLength() {
        // Given
        let line = Line(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        
        // When
        let lenght = line.length
        
        // Then
        XCTAssertEqual(1, lenght)
    }

}
