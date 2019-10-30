//
//  Array+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 28/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    
    func split() -> (left: [Element], right: [Element]) {
        let max = self.count
        let half = max / 2
        //Adding one for an overlap to reduce gaps that may occure between lines
        return (left: Array(self[0 ..< half+1]), right: Array(self[half ..< max]))
    }
    
    func replaceLast(_ element: Element) -> [Element] {
        var array = self.dropLast()
        array.append(element)
        return Array(array)
    }
    
}

extension Array where Element : FloatingPoint {
    
    func rootMeanSquared() -> CGFloat {
        return (self.map { ($0 as! CGFloat) * ($0 as! CGFloat) }.reduce(0, +) / CGFloat(self.count)).squareRoot()
    }
    
}
