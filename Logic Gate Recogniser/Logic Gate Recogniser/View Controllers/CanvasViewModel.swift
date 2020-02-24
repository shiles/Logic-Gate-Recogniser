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
    private weak var analysisTimer: Timer?
    private var gateSubscriber: AnyCancellable?
    
    // External State
    weak var delegate: CanvasDrawer?
    private(set) var gates: [Gate] = []
    private(set) var adjacentShapes: [[Shape]] = [] {
        didSet {
            print(adjacentShapes)
            self.delegate?.updateCanvas()
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
        if tool == .erasor {
            gates = gateManager.eraseGate(erasorStroke: stroke, in: gates)
            adjacentShapes = shapeRecogniser.eraseShapes(erasorStroke: stroke, in: adjacentShapes)
        } else {
            adjacentShapes = shapeRecogniser.recogniseShape(from: stroke , into: adjacentShapes)
        }
        
        startTimer()
    }
    
    ///Handle the user moving across canvas
    func strokeMoved() {
        invalidateTimer()
    }
    
    ///Resets the state of held by the canvas
    func resetState() {
        gates = []
        adjacentShapes = []
    }
    
    // MARK: Input Timer Functions
    
    ///Invalidates the timer which is counting down because the user has interacted with the canvas
    private func invalidateTimer() {
        analysisTimer?.invalidate()
    }
    
    ///Starts the timer which will perform the analysis of the shapes once the user is done with interacting with canvas
    private func startTimer() {
        analysisTimer = Timer.scheduledTimer(
            timeInterval: 1.5,
            target: self,
            selector: #selector(performAnalysis),
            userInfo: nil,
            repeats: false)
    }
    
    // MARK: Analysis Methods
    
    ///Performs the analysis on the shapes that have been recognised once theyre
    @objc private func performAnalysis() {
        adjacentShapes = shapeRecogniser.performAnalysis(in: adjacentShapes)
    }
    
}
