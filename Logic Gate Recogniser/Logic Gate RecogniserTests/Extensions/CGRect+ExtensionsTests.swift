//
//  CGRect+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 04/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
import UIKit

class CGRect_ExtensionsTests: XCTestCase {

    func testInflation() {
        // Given
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // When
        let inflated = rect.inflate(by: 1.1)
        
        // Then
        XCTAssertEqual(inflated.minX, -5.0, accuracy: 0.01)
        XCTAssertEqual(inflated.maxX, 105.0, accuracy: 0.01)
        XCTAssertEqual(inflated.minY, -5.0, accuracy: 0.01)
        XCTAssertEqual(inflated.maxY, 105.0, accuracy: 0.01)
    }
    
    func testSquared() {
        // Given
        let rect = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        // When
        let squared = rect.squared()
        
        // Then
        XCTAssertEqual(50, squared.width)
        XCTAssertEqual(50, squared.height)
    }
    
    func testCentralInitPoint() {
        // Given
        let rect = CGRect(center: CGPoint(x: 0, y: 0))
        
        // Then
        XCTAssertEqual(rect.minX, -10)
        XCTAssertEqual(rect.maxX, 10)
        XCTAssertEqual(rect.minY, -10)
        XCTAssertEqual(rect.maxY, 10)
    }

}
