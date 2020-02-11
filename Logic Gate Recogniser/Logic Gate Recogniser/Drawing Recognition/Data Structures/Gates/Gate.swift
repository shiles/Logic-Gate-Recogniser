//
//  Gate.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

enum Gate {
    case not, or, nor, and, nand, xor, xnor
}

extension Gate {
    
    ///All the types of gates
    static var allTypes: [Gate] {
        [.not, .or, .nor, .and, .nand, .xor, .xnor]
    }
    
}
