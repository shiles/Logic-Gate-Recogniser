//
//  GateManagerTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 01/04/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class GateManagerTests: XCTestCase {

    let gateManager = GateManager()
    
    // MARK: - Manage Gates Tests
    
    func testEraseGateStokeNotIntersect() {
        // Given
        let eraserStroke = [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 10)]
        let gate = GateType.buildGate(of: .not, at: CGRect(center: CGPoint(x: 100, y: 100)))
        let model: GateModel = ([], [gate])
        
        // When
        let result = gateManager.eraseGate(erasorStroke: eraserStroke, in: model)
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertTrue(result.gates.first is Not)
    }
    
    func testEraseGatesStrokeIntersects() {
        // Given
        let eraserStroke = [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 10)]
        let gate = GateType.buildGate(of: .not, at: CGRect(center: CGPoint(x: 0, y: 0)))
        let model: GateModel = ([], [gate])
        
        // When
        let result = gateManager.eraseGate(erasorStroke: eraserStroke, in: model)
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertTrue(result.gates.isEmpty)
    }
    
    func testEraseGateRemovesConnection() {
        // Given
        let eraserStroke  = [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 10)]
        var not = GateType.buildGate(of: .not, at: CGRect(center: CGPoint(x: 1, y: 9)))
        let and = GateType.buildGate(of: .and, at: .zero)
        let connection = Connection(startGate: and, endGate: not, stroke: [])
        not.inputs = [and]
        let model = ([connection], [not, and])
        
        // When
        let result = gateManager.eraseGate(erasorStroke: eraserStroke, in: model)
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertEqual(result.gates.count, 1)
        XCTAssertTrue(result.gates.first is And)
    }
    
    // MARK: - Manage Connection Tests
    
    func testRecogniseInputGateTrueFromConnection() {
        // Given
        let stroke = StrokeBuilder.incompleteTriangle
        
        // When
        let result = gateManager.analyseConnections(stroke: stroke, in: ([],[]))
        
        // Then
        XCTAssertTrue(result.gates.first is Input)
        XCTAssertTrue(result.gates.first!.output)
    }
    
    func testRecogniseInputGateFalseFromConnection() {
        // Given
        let stroke = StrokeBuilder.circle
        
        // When
        let result = gateManager.analyseConnections(stroke: stroke, in: ([],[]))
        
        // Then
        XCTAssertTrue(result.gates.first is Input)
        XCTAssertFalse(result.gates.first!.output)
    }
    
    func testRecogniseOuputFromConnection() {
        // Given
        let stroke = StrokeBuilder.rectangle
        
        // When
        let result = gateManager.analyseConnections(stroke: stroke, in: ([],[]))
        
        // Then
        XCTAssertTrue(result.gates.first is Output)
    }
    
    func testUpdateInputValueFalseToTrue() {
        // Given
        let stroke = StrokeBuilder.incompleteTriangle
        let input = Input(boundingBox: CGRect(center: CGPoint(x: 131.0, y: 284.5)), initialValue: false)
        
        // When
        let result = gateManager.analyseConnections(stroke: stroke, in: ([], [input]))
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertEqual(result.gates.count, 1)
        XCTAssertTrue(result.gates.first!.output)
    }
    
    func testUpdateInputValueTrueToFalse() {
        // Given
        let stroke = StrokeBuilder.circle
        let input = Input(boundingBox: CGRect(center: CGPoint(x: 301.5, y: 395.0)), initialValue: true)
        
        // When
        let result = gateManager.analyseConnections(stroke: stroke, in: ([], [input]))
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertEqual(result.gates.count, 1)
        XCTAssertFalse(result.gates.first!.output)
    }
    
    func testEraseConnectionBetweenGates() {
        // Given
        let eraserStroke = [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 3)]
        var not = GateType.buildGate(of: .not, at: CGRect(center: CGPoint(x: 1, y: 9)))
        let and = GateType.buildGate(of: .and, at: .zero)
        let connection = Connection(startGate: and, endGate: not, stroke: [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 3)])
        not.inputs = [and]
        let model = ([connection], [not, and])
        
        // When
        let result = gateManager.eraseConnection(erasorStroke: eraserStroke, in: model)
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertEqual(result.gates.count, 2)
        XCTAssertTrue(result.gates.first!.inputs.isEmpty)
    }
    
    func testAddConnectionBetweenGates() {
        // Given
        let connectionStroke = [CGPoint.zero, CGPoint(x: 210, y: 210)]
        let not = Not(boundingBox: CGRect(origin: CGPoint(x: 200, y: 200), size: CGSize.square))
        let input = Input(boundingBox: CGRect(origin: CGPoint.zero, size: CGSize.square), initialValue: false)

        // When
        let result = gateManager.analyseConnections(stroke: connectionStroke, in: ([], [not, input]))
        
        // Then
        XCTAssertEqual(result.connections.first, Connection(startGate: input, endGate: not, stroke: connectionStroke))
        XCTAssertTrue(not.inputs.first is Input)
    }
    
    func testAddConnectionBetweenGatesNotConnects() {
        // Given
        let connectionStroke = [CGPoint(x: 10, y: 10), CGPoint(x: 11, y: 11)]
        let not = Not(boundingBox: CGRect(origin: CGPoint(x: 200, y: 200), size: CGSize.square))
        let input = Input(boundingBox: CGRect(origin: CGPoint.zero, size: CGSize.square), initialValue: false)

        // When
        let result = gateManager.analyseConnections(stroke: connectionStroke, in: ([], [not, input]))
        
        // Then
        XCTAssertTrue(result.connections.isEmpty)
        XCTAssertTrue(not.inputs.isEmpty)
    }
}

extension CGSize {
    
    static var square: CGSize {
        CGSize(width: 100, height: 100)
    }
    
}
