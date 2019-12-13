//
//  Collection+ExtensionsTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 13/12/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class Collection_ExtensionsTests: XCTestCase {

    func testSafeIndexWithValues() {
        // Given
        let array = [1,2,3,4]
        
        // When
        let element = array[safe: 3]
        
        // Then
        XCTAssertEqual(element, Optional(4))
    }
    
    func testSafeIndexNoValues() {
        // Given
        let array = [1,2,3,4]
        
        // When
        let element = array[safe: 4]
        
        // Then
        XCTAssertEqual(element, Optional(nil))
    }
}
