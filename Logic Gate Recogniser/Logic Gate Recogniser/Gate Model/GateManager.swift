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
    func eraseGate(erasorStroke: Stroke, in gateModel: GateModel) -> GateModel {
        var connections = gateModel.connections
        var gates: [Gate] = []
        
        gateModel.gates.forEach { gate in
            if !erasorStroke.map({ gate.path.contains($0) }).contains(true) {
                gates.append(gate)
            } else {
                connections.removeAll(where: { $0.startGate == gate || $0.endGate == gate })
            }
        }
    
        return (connections, gates)
    }
    
    ///Adds a conection between gates if both ends of the stroke connect with a gate
    ///- Parameter connectionStroke:The stroke indicating the two lines that people want to connect
    ///- Parameter model: The gates that are on the canvas
    ///- Returns: A list of gates with the new connection added if possible
    func addConnection(connectionStroke: Stroke, into model: GateModel) -> GateModel {
        guard let start = connectionStroke.first, let end = connectionStroke.last else { return model }
        
        let startGate = model.gates.first(where: { $0.boundingBox.intersects(start.boundingBox) })
        var endGate = model.gates.first(where: { $0.boundingBox.intersects(end.boundingBox) })
        
        if let _ = startGate, let _ = endGate {
            // Check that it doesn't already have to many inputs
            if endGate!.description == "Not" {
                if endGate!.inputs.count >= 1 { return model }
            } else {
                if endGate!.inputs.count >= 2 { return model }
            }
            
            // Create the conection
            var connections = model.connections
            connections.append(Connection(startGate: startGate!, endGate: endGate!, stroke: connectionStroke))
            endGate!.inputs.append(startGate!)
            
            return (connections, model.gates)
        }
        
        return model
    }
    
    ///Erases a connection from the list if the erasor stroke intersects the connection
    ///- Parameter erasorStroke: The stroke indicating what the user would like to remove
    ///- Parameter model: The gates are on the canvas
    ///- Returns: A list of gates that have been removed
    func eraseConnection(erasorStroke: Stroke, in model: GateModel) -> GateModel {
        let erasorBoundingBox = erasorStroke.boundingBox
        var connections: [Connection] = []
            
        model.connections.forEach { connection in
            if connection.stroke.boundingBox.intersects(erasorBoundingBox) {
                if connection.stroke.interesects(with: erasorStroke) {
                    var endGate = model.gates.first(where: { $0 == connection.endGate })
                    endGate?.inputs.removeAll(where: {$0 == connection.startGate })
                } else {
                    connections.append(connection)
                }
            }
        }
        
        return (connections, model.gates)
    }
        
}
