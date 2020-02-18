//
//  CanvasViewModel.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

class CanvasViewModel {
    
    // Internal State
    private let drawingRecogniser = ShapeRecogniser()
    private weak var analysisTimer: Timer?
    
    // External State
    private(set) var adjacentShapes: [[Shape]] = []
    private(set) var gates: [Gate] = []
    
    // MARK: User Input Functions
    
    func strokeMoved() {
        invalidateTimer()
    }
    
    func strokeFinished(stroke: Stroke, tool: DrawingTools) {
        if tool == .erasor {
            // Do something
        }
        
        adjacentShapes = drawingRecogniser.recogniseShape(from: stroke , into: adjacentShapes)
        startTimer()
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
