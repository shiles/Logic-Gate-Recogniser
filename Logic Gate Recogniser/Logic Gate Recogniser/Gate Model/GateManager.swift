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
    func eraseGate(erasorStroke: Stroke, in knownGates: GateModel) -> GateModel {
        var gates: GateModel = []
        
        knownGates.forEach { gate in
            if !erasorStroke.map({ gate.path.contains($0) }).contains(true) {
                gates.append(gate)
            }
        }
    
        return gates
    }
    
    func eraseConnection() {
        
    }
    
    func addConnection(connection: Stroke, into model: GateModel) -> GateModel {
        
        
        
        return model
    }
    
}
