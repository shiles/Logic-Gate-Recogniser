//
//  CGPoint_ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
import UIKit
@testable import Recogniser

class CGPoint_ExtensionsTests: XCTestCase {
    
    func testToVector() {
        // Given
        let point = CGPoint(x: 1, y: 1)
        
        // When
        let vect = point.vector
        
        // Then
        XCTAssertEqual(vect, CGVector(dx: 1, dy: 1))
    }
    
    func testPointSubtraction() {
        // Given
        let pnt1 = CGPoint(x: 10, y: 10)
        let pnt2 = CGPoint(x: 5,  y: 5)
        
        // When
        let result = pnt1 - pnt2
        
        // Then
        XCTAssertEqual(result, CGPoint(x: 5, y: 5))
    }
}
