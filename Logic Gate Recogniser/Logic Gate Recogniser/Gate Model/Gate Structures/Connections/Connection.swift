//
//  Connection.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 12/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

struct Connection {
    let startGate: Gate
    let endGate: Gate
    let stroke: Stroke
}

extension Connection: CustomStringConvertible {
    var description: String { "Connection from \(startGate) to \(endGate)" }
}
