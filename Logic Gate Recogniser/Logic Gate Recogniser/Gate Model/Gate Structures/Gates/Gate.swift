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
    var path: UIBezierPath { get }
    var inputs: [Gate] { get set }
    var output: Bool { get }
    var hasChanged: Bool { get }
    
    ///Draws the gate at a starting point to fill a certain size
    ///- Parameter context: Context to draw the gate into
    func draw(with context: CGContext)
    
    ///Simulates the logic gate
    func run()
}
 
func == (lhs: Gate, rhs: Gate) -> Bool {
    lhs.boundingBox == rhs.boundingBox
}

extension Gate {
    
    ///Test to see if the gate matches a predicate
    ///- Parameter predicate: Predicate to test against
    ///- Returns: Boolean value wether the gate matches or doesn't
    func has(matching predicate: Predicate<Gate>) -> Bool {
        return predicate.matches(self)
    }
    
    ///Adds the required inputs to a gate for testing
    ///- Parameter inputA: First input for the gate
    ///- Parameter inputB: Second optional input, provide if required
    mutating func withInput(inputA: Bool, inputB: Bool? = nil) {
        let inA = Input(boundingBox: .zero, initialValue: inputA)
        var inB: Input?

        if let inputB = inputB { inB = Input(boundingBox: .zero, initialValue: inputB) }

        self.inputs = [inA, inB].compactMap { $0 }
    }
    
}
