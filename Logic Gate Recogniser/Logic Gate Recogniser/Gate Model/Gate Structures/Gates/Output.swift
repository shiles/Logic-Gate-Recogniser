//
//  Output.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class Output: Gate {
    var boundingBox: CGRect
    var description: String = ""
    var inputs: [Gate] = []
    var output: Bool = false
    var hasChanged: Bool = true
    
    var path: UIBezierPath = { UIBezierPath() }()
    
    init(boundingBox: CGRect) {
        self.boundingBox = boundingBox
    }
    
    func draw(with context: CGContext) {
        UIGraphicsPushContext(context)
        let drawable = path
        drawable.setDefaultAttributes()
        drawable.stroke()
        UIGraphicsPopContext()
    }
    
    func run() {
        guard let first = inputs.first?.output else { fatalError() }
        output = first
        hasChanged = false
    }
}
