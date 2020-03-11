//
//  Input.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 11/03/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class Input: Gate {
    var boundingBox: CGRect
    var description: String = ""
    var inputs: [Gate] = []
    var output: Bool = false
    var hasChanged: Bool = false
    
    var path: UIBezierPath = { UIBezierPath() }()
    
    init(boundingBox: CGRect, initialValue: Bool = false) {
        self.boundingBox = boundingBox
        output = initialValue
    }
    
    func draw(with context: CGContext) {
        UIGraphicsPushContext(context)
        let drawable = path
        drawable.setDefaultAttributes()
        drawable.stroke()
        UIGraphicsPopContext()
    }
    
    func run() {}
}

extension Input: Equatable {
    
    static func == (lhs: Input, rhs: Input) -> Bool {
        lhs.boundingBox == rhs.boundingBox
    }
}
