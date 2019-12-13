//
//  CGFloat_ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class CGFloat_ExtensionsTests: XCTestCase {

    func testSquared() {
        // Given
        let val: CGFloat = 2.0
        
        // When
        let sqrd = val.squared()
        
        // Then
        XCTAssertEqual(sqrd, 4.0)
    }

}
