//
//  Gate.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 12/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

protocol Gate {
    var boundingBox: CGRect { get }
    var description: String { get }
    
    ///Draws the gate at a  starting point to fill a certain size
    func draw()
}

struct Not: Gate {
    var description: String { "Not" }
    var boundingBox: CGRect
    
    func draw() {}
}

struct Or: Gate {
    var description: String { "Or" }
    var boundingBox: CGRect
    func draw() {}
}

struct Nor: Gate {
    var description: String { "Nor" }
    var boundingBox: CGRect

    func draw() {}
}

struct And: Gate {
    var description: String { "And" }
    var boundingBox: CGRect

    func draw() {}
}

struct Nand: Gate {
    var description: String { "Nand" }
    var boundingBox: CGRect
    
    func draw() {}
}

struct Xor: Gate {
    var description: String { "Xor" }
    var boundingBox: CGRect
   
   func draw() {}
}

struct Xnor: Gate {
    var description: String { "Xnor" }
    var boundingBox: CGRect
   
    func draw() {}
}
