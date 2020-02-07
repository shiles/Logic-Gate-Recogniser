//
//  RecogniserTests.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 07/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import XCTest
@testable import Recogniser

class RecogniserTests: XCTestCase {

    let recogniser = ShapeAnalyser()
    
    func testExample() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 50), CGPoint(x: 0, y: 100), CGPoint(x: 50, y: 100),
            CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 50), CGPoint(x: 50, y: 50)]
        
        // When
        let convexHull = recogniser.convexHull(of: points)
        
        // Then
    }
    
    func testExample2() {
        // Given
        let points = [CGPoint(x: 4, y: 10), CGPoint(x: 9, y: 7), CGPoint(x: 11, y: 2), CGPoint(x: 2, y: 2)]
        
        // When
        let convexHull = recogniser.convexHull(of: points)
        let area = convexHull!.area
        
        
        // Then
        XCTAssertEqual(area, 45.5)
    }
    
    func test2() {
        // Given
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 100), CGPoint(x: 100, y: 100), CGPoint(x: 100, y: 0)]
        let convexHull = recogniser.convexHull(of: points)!
        
        // When
        let minBound = recogniser.boundingBox(using: convexHull)
        
        // Then
    }
    
    func test3() {
        // Given
        let points = [CGPoint(x: 564.5, y: 449.5), CGPoint(x: 574.0, y: 449.5), CGPoint(x: 582.5, y: 449.5), CGPoint(x: 592.5, y: 449.5), CGPoint(x: 603.5, y: 449.5), CGPoint(x: 618.0, y: 449.5), CGPoint(x: 629.5, y: 454.0), CGPoint(x: 638.5, y: 465.5), CGPoint(x: 644.0, y: 476.5), CGPoint(x: 645.5, y: 486.5),
        CGPoint(x: 648.0, y: 501.5), CGPoint(x: 648.0, y: 513.0), CGPoint(x: 648.0, y: 525.0), CGPoint(x: 643.0, y: 533.0), CGPoint(x: 637.5, y: 537.0), CGPoint(x: 634.0, y: 538.0), CGPoint(x: 629.5, y: 539.5), CGPoint(x: 620.5, y: 541.5), CGPoint(x: 608.5, y: 544.0), CGPoint(x: 599.5, y: 544.0),
        CGPoint(x: 588.0, y: 544.0),
        CGPoint(x: 576.5, y: 538.5),
        CGPoint(x: 566.5, y: 533.5),
        CGPoint(x: 562.0, y: 531.5),
        CGPoint(x: 556.5, y: 528.0),
        CGPoint(x: 554.0, y: 524.5),
        CGPoint(x: 551.0, y: 521.5),
        CGPoint(x: 549.5, y: 519.5),
        CGPoint(x: 548.0, y: 517.0),
        CGPoint(x: 547.0, y: 514.5),
        CGPoint(x: 546.0, y: 510.0),
        CGPoint(x: 546.0, y: 503.0),
        CGPoint(x: 546.0, y: 498.0),
        CGPoint(x: 546.0, y: 492.5),
        CGPoint(x: 548.0, y: 489.0),
        CGPoint(x: 548.5, y: 487.5),
        CGPoint(x: 550.5, y: 485.5),
        CGPoint(x: 553.5, y: 483.5),
        CGPoint(x: 557.5, y: 482.5),
        CGPoint(x: 559.5, y: 482.0),
        CGPoint(x: 564.0, y: 481.5),
        CGPoint(x: 567.5, y: 481.0),
        CGPoint(x: 574.5, y: 481.0),
        CGPoint(x: 577.5, y: 481.0),
        CGPoint(x: 583.0, y: 481.0),
        CGPoint(x: 585.5, y: 481.0),
        CGPoint(x: 588.0, y: 481.0),
        CGPoint(x: 589.5, y: 481.0),
        CGPoint(x: 590.5, y: 481.0),
        CGPoint(x: 592.0, y: 481.0),
        CGPoint(x: 596.0, y: 481.0),
        CGPoint(x: 598.0, y: 481.5),
        CGPoint(x: 599.0, y: 482.0),
        CGPoint(x: 600.0, y: 482.0),
        CGPoint(x: 600.0, y: 482.5),
        CGPoint(x: 600.0, y: 483.0)]

        
        // When
        let hull = recogniser.convexHull(of: points)
        
    }

}
