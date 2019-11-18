//
//  Perimeter.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 18/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

typealias Perimeter = CGFloat

extension Perimeter {
    
    ///Calculate the perimeter from a list of points
    ///- Parameter points: List of points to calculate the perimeter from
    ///- Returns: Perimeter distance
    static func perimeter(of points: [CGPoint]) -> Perimeter? {
        if points.count < 3 { return nil }
        
        return (0...points.lastIndex).map {
            let current = points[$0], next = points[($0+1) % points.count]
            return ((current.x - next.x).squared() + (current.y - next.y).squared()).squareRoot()
        }.reduce(0, +)
    }
}
