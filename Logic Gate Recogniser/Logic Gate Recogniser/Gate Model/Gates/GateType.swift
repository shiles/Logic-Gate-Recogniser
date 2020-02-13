//
//  Gate.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

enum GateType: String {
    case not, or, nor, and, nand, xor, xnor

}

extension GateType {
    
    ///All the types of gates
    static var allTypes: [GateType] {
        [.not, .or, .nor, .and, .nand, .xor, .xnor]
    }
    
    ///Builds the gate object using it's type
    ///- Parameter type: Type of gate
    ///- Parameter boundingBox: Bounding box of size and location to draw
    static func buildGate(of type: GateType, at boundingBox: CGRect) -> Gate {
        switch(type) {
        case .not:
            return Not(boundingBox: boundingBox)
        case .or:
            return Or(boundingBox: boundingBox)
        case .nor:
            return Nor(boundingBox: boundingBox)
        case .and:
            return And(boundingBox: boundingBox)
        case .nand:
            return Nand(boundingBox: boundingBox)
        case .xor:
            return Xor(boundingBox: boundingBox)
        case .xnor:
            return Xnor(boundingBox: boundingBox)
        }
    }
}
