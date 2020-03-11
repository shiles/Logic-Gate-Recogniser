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
