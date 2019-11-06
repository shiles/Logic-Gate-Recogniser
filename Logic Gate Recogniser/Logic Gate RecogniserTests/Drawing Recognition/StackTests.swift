//
//  StackTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 06/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class StackTests: XCTestCase {

    func testTopItem() {
        // Given
        let value = 1
        let stack = Stack<Int>(items: [value])

        // When
        let topItem = stack.topItem
         
        // Then
        XCTAssertEqual(topItem, value)
    }

    func testTopItemNoItems() {
        // Given
        let stack = Stack<Int>()

        // When
        let topItem = stack.topItem

        // Then
        XCTAssertNil(topItem)
    }
    
    func testSndItem() {
        // Given
        let value = 1
        let stack = Stack<Int>(items: [value, 2])

        // When
        let sndItem = stack.sndItem
         
        // Then
        XCTAssertEqual(sndItem, value)
    }

    func testSndItemNoItems() {
        // Given
        let stack = Stack<Int>()

        // When
        let sndItem = stack.sndItem

        // Then
        XCTAssertNil(sndItem)
    }

    func testPushEmptyStack() {
        // Given
        let value = 1
        var stack = Stack<Int>()
        
        // When
        stack.push(value)
        
        // Then
        XCTAssertEqual(stack.topItem, value)
    }
    
    func testPushFullStack() {
        // Given
        let value = 2
        var stack = Stack<Int>(items: [value])
        
        // When
        stack.push(value)
        
        // Then
        XCTAssertEqual(stack.topItem, value)
    }
    
    func testPopFullStack() {
        // Given
        let value = 1
        var stack = Stack<Int>(items: [value])
        
        // When
        let poppedVal = stack.pop()
        
        // Then
        XCTAssertNotNil(poppedVal)
        XCTAssertEqual(poppedVal!, value)
    }
    
    func testPopEmptyStack() {
        // Given
        var stack = Stack<Int>()

        // When
        let poppedVal = stack.pop()

        // Then
        XCTAssertNil(poppedVal)
    }
    
    func testStackIterator() {
        // Given
        let items = [1,2,3]
        let stack = Stack<Int>(items: items)
        
        // When
        let array = Array(stack.asList())
        
        // Then
        XCTAssertEqual(array, items)
    }
}
