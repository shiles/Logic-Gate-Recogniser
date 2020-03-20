//
//  Runner.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

class Runner {
    
    private var timer: Timer?
    private var endSimSub: AnyCancellable?
    
    init() {
        endSimSub = NotificationCenter.Publisher(center: .default, name: .endSimulation, object: nil)
            .sink(receiveValue: { _ in self.stopSimulation() } )
    }
    
    func toggleSimulation(_ model: [Gate]) {
        if let _ = timer {
            stopSimulation()
        } else {
            slowSimulate(model)
        }
    }
    
    private func slowSimulate(_ model: [Gate]) {
        NotificationCenter.default.post(name: .simulationStarted, object: nil)
        model.compactMap{ $0 as? Output }.forEach { $0.hasChanged = true }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            model.forEach { gate in
                gate.run()
                if gate.hasChanged { NotificationCenter.default.post(name: .gateUpdated, object: nil) }
            }
            
            if model.noChange {
                timer.invalidate()
                NotificationCenter.default.post(name: .simulationFinished, object: nil)
            }
        }
        
        let runLoop = RunLoop.current
        runLoop.add(timer!, forMode: .default)
        runLoop.run()
    }
    
    private func stopSimulation() {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.post(name: .simulationFinished, object: nil)
    }
    
    static func simulate(_ model: [Gate]) {
        model.compactMap{ $0 as? Output }.forEach { $0.hasChanged = true }
        
        while(model.outputsDidChange) {
            model.forEach { gate in
                gate.run()
                if gate.hasChanged { NotificationCenter.default.post(name: .gateUpdated, object: nil) }
            }
        }
    }
}
