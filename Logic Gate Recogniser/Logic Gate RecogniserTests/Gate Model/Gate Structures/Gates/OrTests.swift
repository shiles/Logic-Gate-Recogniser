//
//  OrTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class OrTests: XCTestCase {

    func testOrFalseFalse() {
        //Given
        var or = Or(boundingBox: .zero)
        or.withInput(inputA: false, inputB: false)
        
        //When
        or.run()
        
        //Then
        XCTAssertFalse(or.output)
    }
    
    func testOrTrueTrue() {
        //Given
        var or = Or(boundingBox: .zero)
        or.withInput(inputA: true, inputB: true)
        
        //When
        or.run()
        
        //Then
        XCTAssertTrue(or.output)
    }
    
    func testOrFalseTrue() {
        //Given
        var or = Or(boundingBox: .zero)
        or.withInput(inputA: false, inputB: true)
        
        //When
        or.run()
        
        //Then
        XCTAssertTrue(or.output)
    }
    
    func testOrTrueFalse() {
        //Given
        var or = Or(boundingBox: .zero)
        or.withInput(inputA: true, inputB: false)
        
        //When
        or.run()
        
        //Then
        XCTAssertTrue(or.output)
    }

}
