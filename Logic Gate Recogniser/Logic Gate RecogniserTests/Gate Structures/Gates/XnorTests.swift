//
//  XnorTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class XnorTests: XCTestCase {

    func testXnorFalseFalse() {
        //Give
        var xnor = Xnor(boundingBox: .zero)
        xnor.withInput(inputA: false, inputB: false)
        
        //When
        xnor.run()
        
        //Then
        XCTAssertTrue(xnor.output)
    }
    
    func testXnorTrueTrue() {
        //Given
        var xnor = Xnor(boundingBox: .zero)
        xnor.withInput(inputA: true, inputB: true)
        
        //When
        xnor.run()
        
        //Then
        XCTAssertTrue(xnor.output)
    }
    
    func testXnorFalseTrue() {
        //Given
        var xnor = Xnor(boundingBox: .zero)
        xnor.withInput(inputA: false, inputB: true)
        
        //When
        xnor.run()
        
        //Then
        XCTAssertFalse(xnor.output)
    }
    
    func testXnorTrueFalse() {
        //Given
        var xnor = Xnor(boundingBox: .zero)
        xnor.withInput(inputA: true, inputB: false)
        
        //When
        xnor.run()
        
        //Then
        XCTAssertFalse(xnor.output)
    }

}
