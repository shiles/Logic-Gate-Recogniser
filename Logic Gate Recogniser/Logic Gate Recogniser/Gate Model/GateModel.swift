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
    
    private(set) var gates: [Gate] = []
    private var gateSubscriber: AnyCancellable?
    
    init() {
        // When a gate is found it adds it to the model
        gateSubscriber = NotificationCenter.Publisher(center: .default, name: .gateRecognised, object: nil)
            .map { notification in return GateType.getGateType(from: notification.object) }
            .sink(receiveValue: { gate in self.gates.append(gate) })
    }
}
