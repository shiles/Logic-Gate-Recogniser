//
//  CanvasViewModel.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

protocol CanvasDrawer: AnyObject {
    func updateCanvas()
}

class CanvasViewModel {
    
    // Internal State
    private let shapeRecogniser = ShapeRecogniser()
    private let gateManager = GateManager()
    private var gateSubscriber: AnyCancellable?
    
    // Analysis Timer
    private let waitInterval = TimeInterval(exactly: 1.0)!
    private var analysisItem: DispatchWorkItem?
    
    // External State
    weak var delegate: CanvasDrawer?
    private(set) var gates: GateModel = [] {
        didSet {
            DispatchQueue.main.async { self.delegate?.updateCanvas() }
        }
    }
    private(set) var adjacentShapes: [[Shape]] = [] {
        didSet {
            print(adjacentShapes)
            DispatchQueue.main.async { self.delegate?.updateCanvas() }
        }
    }
    private(set) var connections: [Connection] = [] {
        didSet {
            DispatchQueue.main.async { self.delegate?.updateCanvas() }
        }
    }

    // MARK: Initialisers
    
    init() {
        // When a gate is found it adds it to the model
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return notification.object as AnyObject as! Gate }
            .sink(receiveValue: { gate in self.gates.append(gate) })
    }
    
    // MARK: User Input Functions
    
    ///Handle the completion of the user stroke on the canvas
    ///- Parameter stroke: Stroke that the user has drawn
    ///- Parameter tool: The tool the stroke was drawn with
    func strokeFinished(stroke: Stroke, tool: DrawingTools) {
        if tool == .pen {
            DispatchQueue.global(qos: .userInitiated).async {
                self.adjacentShapes = self.shapeRecogniser.recogniseShape(from: stroke , into: self.adjacentShapes)
            }
        }
        
        if tool == .erasor {
            DispatchQueue.global(qos: .userInitiated).async {
                self.gates = self.gateManager.eraseGate(erasorStroke: stroke, in:  self.gates)
                self.adjacentShapes = self.shapeRecogniser.eraseShapes(eraserStroke: stroke, in:  self.adjacentShapes)
            }
        }
        
        if tool == .connector {
            DispatchQueue.global(qos: .userInitiated).async {
                let (connection, model) = self.gateManager.addConnection(connectionStroke: stroke, into: self.gates)
                self.gates = model
                if let connection = connection { self.connections.append(connection) }
            }
        }
        
        scheduleAnalysis()
    }
    
    ///Handle the user moving across canvas
    func strokeMoved() {
        invalidateAnalysis()
    }
    
    ///Resets the state of held by the canvas
    func resetState() {
        gates = []
        adjacentShapes = []
        connections = []
    }
    
    // MARK: Input Analysis Functions
    
    ///Invalidates the timer which is counting down because the user has interacted with the canvas
    private func invalidateAnalysis() {
        analysisItem?.cancel()
    }
    
    ///Sets up the analaysis and executes it
    private func scheduleAnalysis() {
        analysisItem?.cancel()
        
        let workItem = DispatchWorkItem {
             self.adjacentShapes = self.shapeRecogniser.performAnalysis(in: self.adjacentShapes)
        }
        
        analysisItem = workItem
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(
            deadline: .now() + waitInterval,
            execute: workItem
        )
    }
}
