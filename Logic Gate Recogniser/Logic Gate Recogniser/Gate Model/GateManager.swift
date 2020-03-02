//
//  GateManager.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class GateManager {
    
    ///Erases the gates from the list if the erasor strokes intersects the gate
    ///- Parameter erasorStroke: The stroke indicating what the user would like to remove
    ///- Parameter knownGates: The gates are on the canvas
    ///- Returns: A list of gates that have been removed
    func eraseGate(erasorStroke: Stroke, in knownGates: [Gate]) -> [Gate] {
        var gates: [Gate] = []
        
        knownGates.forEach { gate in
            if erasorStroke.map({ gate.path.contains($0) }).contains(false) {
                gates.append(gate)
            }
        }
    
        return gates
    }
    
}
