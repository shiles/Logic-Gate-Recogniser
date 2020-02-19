//
//  UIBezierPath+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class UIBezierPath_ExtensionsTests: XCTestCase {

    func testDefaultAttributesSet() {
        // Given
        let path = UIBezierPath()
        
        // When
        path.setDefaultAttributes()
        
        // Then
        XCTAssertEqual(10, path.lineWidth)
        XCTAssertEqual(.round, path.lineCapStyle)
        XCTAssertEqual(.round, path.lineJoinStyle)
    }
    
    func testScaleToFit() {
        // Given
        let path = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1, height: 1)))
        let boundingBox = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10))
        let expected = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 10, height: 10)))
        
        // When
        path.scaleToFit(boundingBox)
        
        // Then
        XCTAssertEqual(expected, path)
    }

}
