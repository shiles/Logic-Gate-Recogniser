//
//  Runner.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

class Runner {
    
    static func simulate(_ model: [Gate]) {
        model.compactMap{ $0 as? Output }.forEach { $0.hasChanged = true }
        
        while(model.outputsDidChange) {
            model.forEach { gate in
                gate.run()
                if gate.hasChanged { NotificationCenter.default.post(name: .gateUpdated, object: nil) }
            }
        }
    }
}
