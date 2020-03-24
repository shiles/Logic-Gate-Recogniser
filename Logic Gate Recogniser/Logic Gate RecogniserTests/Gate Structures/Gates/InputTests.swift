//
//  InputTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class InputTests: XCTestCase {

    func testInputFalse() {
        //Given
        let input = Input(boundingBox: .zero, initialValue: false)
        
        //Then
        XCTAssertFalse(input.output)
    }
    
    func testInputTrue() {
        //Given
        let input = Input(boundingBox: .zero, initialValue: true)
        
        //Then
        XCTAssertTrue(input.output)
    }

}
