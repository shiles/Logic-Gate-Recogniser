//
//  CanvasViewModel.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

protocol GateDrawer: AnyObject {
    func drawGates(gates: [Gate])
}

class CanvasViewModel {
    
    // Internal State
    private let drawingRecogniser = ShapeRecogniser()
    private weak var analysisTimer: Timer?
    private var gateSubscriber: AnyCancellable?
    
    // External State
    weak var delegate: GateDrawer?
    private(set) var adjacentShapes: [[Shape]] = [] {
        didSet { print(adjacentShapes) }
    }
    private(set) var gates: [Gate] = [] {
        didSet { self.delegate?.drawGates(gates: gates) }
    }
    
    // MARK: Initialisers
    
    init() {
        // When a gate is found it adds it to the model
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return notification.object as AnyObject as! Gate }
            .sink(receiveValue: { gate in self.gates.append(gate) })
    }
    
    // MARK: User Input Functions
    
    func strokeFinished(stroke: Stroke, tool: DrawingTools) {
        if tool == .erasor {
            // Do something
        }
        
        adjacentShapes = drawingRecogniser.recogniseShape(from: stroke , into: adjacentShapes)
        startTimer()
    }
    
    func strokeMoved() {
        invalidateTimer()
    }
    
    // MARK: Input Timer Functions
    
    private func invalidateTimer() {
        analysisTimer?.invalidate()
    }
    
    private func startTimer() {
        analysisTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(performAnalysis),
            userInfo: nil,
            repeats: false)
    }
    
    // MARK: Analysis Methods
    
    ///Performs the analysis on the shapes that have been recognised once theyre
    @objc private func performAnalysis() {
        adjacentShapes = drawingRecogniser.performAnalysis(in: adjacentShapes)
    }
    
}
