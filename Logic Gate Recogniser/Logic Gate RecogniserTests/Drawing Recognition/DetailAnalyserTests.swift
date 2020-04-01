//
//  DetailAnalyser.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 31/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class DetailAnalyserTests: XCTestCase {
    
    let detailAnalyser = DetailAnalyser()
    
    // MARK: - Triangle Tests
    
    func testAnalyseTriangleIncomplete() {
        // Given
        let stroke = StrokeBuilder.incompleteTriangle
        
        // When
        let type = detailAnalyser.analyseTriangle(triangle: stroke)
        
        // Then
        XCTAssertEqual(type, ShapeType.incompleteTriangle)
    }
    
    func testAnalyseTriangleStraight() {
        // Given
        let stroke = StrokeBuilder.straightTriangle
        
        // When
        let type = detailAnalyser.analyseTriangle(triangle: stroke)
        
        // Then
        XCTAssertEqual(type, ShapeType.straightTriangle)
    }
    
    func testAnalyseTriangleCurved() {
        // Given
        let stroke = StrokeBuilder.curvedTriangle
        
        // When
        let type = detailAnalyser.analyseTriangle(triangle: stroke)
        
        // Then
        XCTAssertEqual(type, ShapeType.curvedTriangle)
    }
    
    // MARK: - Square Tests
    
    func testAnalyseRectangleRectangle() {
        // Given
        let stroke = StrokeBuilder.rectangle
        
        // When
        let type = detailAnalyser.analyseRectangle(rectangle: stroke)
        
        // Then
        XCTAssertEqual(type, ShapeType.rectangle)
    }
    
    func testAnalyseRectangleCurvedLine() {
        // Given
        let stroke = StrokeBuilder.curvedLine
        
        // When
        let type = detailAnalyser.analyseRectangle(rectangle: stroke)
        
        // Then
        XCTAssertEqual(type, ShapeType.curvedLine)
    }
}
