//
//  GateManager.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class GateManager {
    
    func eraseGate(erasorStroke: Stroke, in knownGates: [Gate]) -> [Gate] {
        var gates: [Gate] = []
        
        knownGates.forEach { gate in
            if !erasorStroke.map({ gate.path.contains($0) }).contains(true) {
                gates.append(gate)
            }
        }
    
        return gates
    }
    
}
