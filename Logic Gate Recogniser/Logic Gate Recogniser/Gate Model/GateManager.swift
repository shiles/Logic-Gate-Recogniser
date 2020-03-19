//
//  GateManager.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class GateManager {
    
    private let recogniser = ShapeRecogniser()
    private let detailAnalyser = DetailAnalyser()
    
    // MARK: Manage Gates
    
    ///Erases the gates from the list if the erasor strokes intersects the gate
    ///- Parameter erasorStroke: The stroke indicating what the user would like to remove
    ///- Parameter model: The gates are on the canvas
    ///- Returns: A list of gates that have been removed
    func eraseGate(erasorStroke: Stroke, in gateModel: GateModel) -> GateModel {
        var connections = gateModel.connections
        var gates: [Gate] = []
        var removedGates: [Gate] = []
        
        gateModel.gates.forEach { gate in
            if !erasorStroke.map({ gate.path.contains($0) }).contains(true) {
                gates.append(gate)
            } else {
                removedGates.append(gate)
                connections.removeAll(where: { $0.startGate == gate || $0.endGate == gate })
            }
        }
        
        for i in 0..<gates.count {
            gates[i].inputs.removeAll(where: { gate in removedGates.filter{ $0 == gate}.count == 1 })
        }
    
        return (connections, gates)
    }
    

    ///Finds if there is an input gate that has been drawn
    ///- Parameter stroke: The stroke the user has drawn onto the canvas
    ///- Returns: An optional gate, either input or output or nil if neither was found within the stroke
    private func findCircuitGate(stroke: Stroke) -> Gate? {
        guard let shape = recogniser.analyseStroke(stroke) else { return nil }
        
        if shape.type == .rectangle && detailAnalyser.analyseRectangle(rectangle: stroke) == .rectangle  {
             return Output(boundingBox: shape.boundingBox)
        }
        
        if shape.type == .unanalysedTriangle {
            return Input(boundingBox: shape.boundingBox, initialValue: true)
        }
        
        if shape.type == .circle {
            return Input(boundingBox: shape.boundingBox, initialValue: false)
        }
        
        return nil
    }
    
    // MARK: Manage Connections
    
    ///Analyses the connection to see if it is a in/out gate or if it's a connection between gates and apply that to the model
    ///- Parameter stroke: The stroke the user has drawn onto the canvas
    ///- Parameter model: The gates and connections are on the canvas
    ///- Returns: A model with ammended connections
    func analyseConnections(stroke: Stroke, in model: GateModel) -> GateModel {
        if let gate = findCircuitGate(stroke: stroke) {
            let intersects = model.gates.filter { $0.boundingBox.intersects(gate.boundingBox) }
            if intersects.hasElements {
                intersects.forEach {
                    if let input = $0 as? Input { input.modifyOutput(to: gate.output) }
                }
                return model
            } else {
                var gates = model.gates
                gates.append(gate)
                return (model.connections, gates)
            }
        } else {
            return addConnection(connectionStroke: stroke, into: model)
        }
    }
    
    ///Adds a conection between gates if both ends of the stroke connect with a gate
    ///- Parameter connectionStroke:The stroke indicating the two lines that people want to connect
    ///- Parameter model: The gates that are on the canvas
    ///- Returns: A list of gates with the new connection added if possible
    private func addConnection(connectionStroke: Stroke, into model: GateModel) -> GateModel {
        guard let start = connectionStroke.first, let end = connectionStroke.last else { return model }
        
        let startGate = model.gates.first(where: { $0.boundingBox.intersects(start.boundingBox) })
        var endGate = model.gates.first(where: { $0.boundingBox.intersects(end.boundingBox) })
        
        if let _ = startGate, let _ = endGate {
            // Check that it doesn't already have to many inputs
            if endGate!.has(matching: .isNoInput) {
                return model
            } else if endGate!.has(matching: .isSingleInput) {
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
                }
            } else {
                connections.append(connection)
            }
        }
        
        return (connections, model.gates)
    }
        
}
