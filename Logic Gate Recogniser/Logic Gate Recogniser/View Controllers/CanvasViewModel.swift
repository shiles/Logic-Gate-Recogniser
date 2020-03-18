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
    private(set) var gateModel: GateModel = ([],[]) {
        didSet {
            DispatchQueue.main.async { self.delegate?.updateCanvas() }
        }
    }
    private(set) var adjacentShapes: [[Shape]] = [] {
        didSet {
            DispatchQueue.main.async { self.delegate?.updateCanvas() }
        }
    }

    // MARK: Initialisers
    
    init() {
        // When a gate is found it adds it to the model
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return notification.object as AnyObject as! Gate }
            .sink(receiveValue: { gate in self.gateModel.gates.append(gate) })
    }
    
    // MARK: User Input Functions
    
    ///Handle the completion of the user stroke on the canvas
    ///- Parameter stroke: Stroke that the user has drawn
    ///- Parameter tool: The tool the stroke was drawn with
    func strokeFinished(stroke: Stroke, tool: DrawingTools) {
        if tool == .pen {
            DispatchQueue.global(qos: .userInitiated).async {
                self.adjacentShapes = self.shapeRecogniser.recogniseShape(from: stroke, into: self.adjacentShapes)
            }
        }
        
        if tool == .erasor {
            DispatchQueue.global(qos: .userInitiated).async {
                self.gateModel = self.gateManager.eraseGate(erasorStroke: stroke, in:  self.gateModel)
                self.gateModel = self.gateManager.eraseConnection(erasorStroke: stroke, in: self.gateModel)
                self.adjacentShapes = self.shapeRecogniser.eraseShapes(eraserStroke: stroke, in:  self.adjacentShapes)
            }
        }
        
        if tool == .connector {
            DispatchQueue.global(qos: .userInitiated).async {
                self.gateModel = self.gateManager.analyseConnections(stroke: stroke, in: self.gateModel)
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
        gateModel = ([],[])
        adjacentShapes = []
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
