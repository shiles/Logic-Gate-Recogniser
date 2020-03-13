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
}
