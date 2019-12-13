//
//  Angle+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class Angle_ExtensionsTests: XCTestCase {

    func testAngleToDegrees() {
        // Given
        let angle: Angle = 2.4
        
        // Then
        let deg = angle.toDegrees()
        
        // When
        XCTAssertEqual(deg, 137.50987083139756)
    }

}
