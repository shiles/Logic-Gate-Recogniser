//
//  NotTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class NotTests: XCTestCase {
    
    func testNotFalse() {
        //Given
        var not = Not(boundingBox: .zero)
        not.withInput(inputA: false)
        
        //When
        not.run()
        
        //Then
        XCTAssertTrue(not.output)
    }
    
    func testNotTrue() {
        //Given
        var not = Not(boundingBox: .zero)
        not.withInput(inputA: true)
        
        //When
        not.run()
        
        //Then
        XCTAssertFalse(not.output)
    }

}
