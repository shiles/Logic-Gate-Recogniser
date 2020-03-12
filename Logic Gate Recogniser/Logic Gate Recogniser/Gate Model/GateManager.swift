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
    ///- Parameter model: The gates are on the canvas
    ///- Returns: A list of gates that have been removed
    func eraseGate(erasorStroke: Stroke, in model: GateModel) -> GateModel {
        var gates: GateModel = []
        
        model.forEach { gate in
            if !erasorStroke.map({ gate.path.contains($0) }).contains(true) {
                gates.append(gate)
            }
        }
    
        return gates
    }
    
    ///Erases a connection from the list if the erasor stroke intersects the connection
    ///- Parameter erasorStroke: The stroke indicating what the user would like to remove
    ///- Parameter model: The gates are on the canvas
    ///- Returns: A list of gates that have been removed
    func eraseConnection(erasorStroke: Stroke, in model: GateModel) -> GateModel {
        
        return model
    }
    
    ///Adds a conection between gates if both ends of the stroke connect with a gate
    ///- Parameter connectionStroke:The stroke indicating the two lines that people want to connect
    ///- Parameter model: The gates that are on the canvas
    ///- Returns: A list of gates with the new connection added if possible
    func addConnection(connectionStroke: Stroke, into model: GateModel) -> (Connection?, GateModel) {
        guard let start = connectionStroke.first, let end = connectionStroke.last, start != end else {
            return (nil, model)
        }
        
        let startGate = model.first(where: { $0.boundingBox.intersects(start.boundingBox) })
        var endGate = model.first(where: { $0.boundingBox.intersects(end.boundingBox) })
        
        if let _ = startGate, let _ = endGate {
            // Check that it doesn't already have to many inputs
            if endGate!.description == "Not" {
                if endGate!.inputs.count >= 1 { return (nil, model) }
            } else {
                if endGate!.inputs.count >= 2 { return (nil, model) }
            }
            
            // Create the conection
            let connection = Connection(startGate: startGate!, endGate: endGate!, stroke: connectionStroke)
            endGate!.inputs.append(startGate!)
            
            return (connection, model)
        }
        
        return (nil, model)
    }
    
}
