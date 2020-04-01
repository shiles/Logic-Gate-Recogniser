//
//  GateTypeTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 01/04/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class GateTypeTests: XCTestCase {

    func testBuildGatesNot() {
        // Given
        let type: GateType = .not
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Not)
    }
    
    func testBuildGatesOr() {
        // Given
        let type: GateType = .or
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Or)
    }
    
    func testBuildGatesNor() {
        // Given
        let type: GateType = .nor
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Nor)
    }
    
    func testBuildGatesAnd() {
        // Given
        let type: GateType = .and
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is And)
    }
    
    func testBuildGatesNand() {
        // Given
        let type: GateType = .nand
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Nand)
    }
    
    func testBuildGatesXor() {
        // Given
        let type: GateType = .xor
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Xor)
    }
    
    func testBuildGatesXnor() {
        // Given
        let type: GateType = .xnor
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Xnor)
    }
    
    func testBuildGateInput() {
        // Given
        let type: GateType = .input
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Input)
    }
    
    func testBuildGateOutput() {
        // Given
        let type: GateType = .output
        
        // When
        let gate = GateType.buildGate(of: type, at: CGRect.zero)
        
        // Then
        XCTAssertTrue(gate is Output)
    }
    
}
