//
//  GateModel.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 12/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import Combine

class GateModel {
    
    private var gateSubscriber: AnyCancellable?
    private(set) var gates: [Gate] = [] {
        didSet { drawGatesClosure?() }
    }
    
    var drawGatesClosure: (()->())?
    
    init() {
        // When a gate is found it adds it to the model
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return notification.object as AnyObject as! Gate }
            .sink(receiveValue: { gate in self.gates.append(gate) })
    }
}
