//
//  NorTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class NorTests: XCTestCase {

    func testNorFalseFalse() {
        //Give
        var nor = Nor(boundingBox: .zero)
        nor.withInput(inputA: false, inputB: false)
        
        //When
        nor.run()
        
        //Then
        XCTAssertTrue(nor.output)
    }
    
    func testNorTrueTrue() {
        //Given
        var nor = Nor(boundingBox: .zero)
        nor.withInput(inputA: true, inputB: true)
        
        //When
        nor.run()
        
        //Then
        XCTAssertFalse(nor.output)
    }
    
    func testNorFalseTrue() {
        //Given
        var nor = Nor(boundingBox: .zero)
        nor.withInput(inputA: false, inputB: true)
        
        //When
        nor.run()
        
        //Then
        XCTAssertFalse(nor.output)
    }
    
    func testNorTrueFalse() {
        //Given
        var nor = Nor(boundingBox: .zero)
        nor.withInput(inputA: true, inputB: false)
        
        //When
        nor.run()
        
        //Then
        XCTAssertFalse(nor.output)
    }
}
