//
//  XorTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class XorTests: XCTestCase {

    func testXorFalseFalse() {
        //Give
        var xor = Xor(boundingBox: .zero)
        xor.withInput(inputA: false, inputB: false)
        
        //When
        xor.run()
        
        //Then
        XCTAssertFalse(xor.output)
    }
    
    func testXorTrueTrue() {
        //Given
        var xor = Xor(boundingBox: .zero)
        xor.withInput(inputA: true, inputB: true)
        
        //When
        xor.run()
        
        //Then
        XCTAssertFalse(xor.output)
    }
    
    func testXorFalseTrue() {
        //Given
        var xor = Xor(boundingBox: .zero)
        xor.withInput(inputA: false, inputB: true)
        
        //When
        xor.run()
        
        //Then
        XCTAssertTrue(xor.output)
    }
    
    func testXorTrueFalse() {
        //Given
        var xor = Xor(boundingBox: .zero)
        xor.withInput(inputA: true, inputB: false)
        
        //When
        xor.run()
        
        //Then
        XCTAssertTrue(xor.output)
    }

}
