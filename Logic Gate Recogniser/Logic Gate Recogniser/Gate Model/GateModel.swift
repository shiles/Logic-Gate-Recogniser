//
//  GateModel.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

typealias GateModel = [Gate]

extension GateModel {
    
    var outputsDidChange: Bool {
        self.map(\.hasChanged).contains(true)
    }
    
}
