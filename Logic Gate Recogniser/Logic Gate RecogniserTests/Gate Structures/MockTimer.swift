//
//  MockTimer.swift
//  Logic Gate RecogniserTests
//
//  Created by Sonnie Hiles on 24/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class MockTimer: Timer {
    
    var block: ((Timer) -> Void)!
    
    static var currentTimer: MockTimer!

    override func fire() {
        block(self)
    }
    
    override open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        let mockTimer = MockTimer()
        mockTimer.block = block
        MockTimer.currentTimer = mockTimer
        return mockTimer
    }
}
