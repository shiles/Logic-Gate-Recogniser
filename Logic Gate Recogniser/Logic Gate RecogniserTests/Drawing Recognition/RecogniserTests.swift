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


}
