//
//  Predicate.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 10/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

struct Predicate<Target> {
    var matches: (Target) -> Bool

    init(matcher: @escaping (Target) -> Bool) {
        matches = matcher
    }
}

extension Predicate where Target == Shape {
   
    ///Predicate to check if the shape is a line, either `line` or `curvedLine`
    static var isLine: Self {
        Predicate {
            $0.type == .line || $0.type == .curvedLine
        }
    }
    
    ///Predicate to check if the shape is a `curvedLine`
    static var isCurved: Self {
        Predicate {
            $0.type == .curvedLine
        }
    }
}
