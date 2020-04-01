//
//  OutputTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class OutputTests: XCTestCase {

    func testInputFalse() {
        //Given
        var output = Output(boundingBox: .zero)
        output.withInput(inputA: false)
        
        //When
        output.run()

        //Then
        XCTAssertFalse(output.output)
    }

    func testInputTrue() {
        //Given
        var output = Output(boundingBox: .zero)
        output.withInput(inputA: true)
        
        //When
        output.run()

        //Then
        XCTAssertTrue(output.output)
    }

}
