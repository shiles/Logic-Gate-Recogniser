//
//  Bool+Extensions.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class Bool_Extensions: XCTestCase {

    func testXorOperatorTrueTrue() {
        // Given
        let a = true
        let b = true
        
        // When
        let rslt = a ^ b
        
        // Then
        XCTAssertFalse(rslt)
    }
    
    func testXorOperatorFalseFalse() {
        // Given
        let a = false
        let b = false
        
        // When
        let rslt = a ^ b
        
        // Then
        XCTAssertFalse(rslt)
    }
    
    func testXorOperatorTrueFalse() {
        // Given
        let a = true
        let b = false
        
        // When
        let rslt = a ^ b
        
        // Then
        XCTAssertTrue(rslt)
    }
    
    func testXorOperatorFalseTrue() {
        // Given
        let a = false
        let b = true
        
        // When
        let rslt = a ^ b
        
        // Then
        XCTAssertTrue(rslt)
    }

}
