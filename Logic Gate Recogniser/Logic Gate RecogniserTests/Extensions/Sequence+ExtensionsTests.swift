//
//  Sequence+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 19/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
import UIKit

class Sequence_ExtensionsTests: XCTestCase {

    func testKeyPathMap() {
        // Given
        let points = [CGPoint()]
        
        // When
        let xCords = points.map(\.x)
        
        // Then
        XCTAssertEqual([0], xCords)
    }

}
