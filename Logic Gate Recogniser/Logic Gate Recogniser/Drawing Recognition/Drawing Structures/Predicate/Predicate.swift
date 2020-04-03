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

func ==<T, V: Equatable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    Predicate { $0[keyPath: lhs] == rhs }
}

prefix func !<T>(rhs: KeyPath<T, Bool>) -> Predicate<T> {
    rhs == false
}

func &&<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { lhs.matches($0) && rhs.matches($0) }
}

func ||<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { lhs.matches($0) || rhs.matches($0) }
}

extension Predicate where Target == Shape {
   
    ///Predicate to check if the shape is a line, either `line` or `curvedLine`
    static var isLine: Self {
        Predicate {
            switch($0.type){
            case .line(type: _):
                return true
            default:
                return false
            }
        }
    }
    
    ///Predicate to check if the shape is a triangle, either `line` or `curvedLine`
    static var isTriangle: Self {
        Predicate {
            switch($0.type){
            case .triangle(type: _):
                return true
            default:
                return false
            }
        }
    }
}

extension Predicate where Target == GateType {
    
    ///Predicate for the gates that contain circles
    static var containsCircle: Self {
        Predicate {
            [.not, .nor, .nand, .xnor].contains($0)
        }
    }
    
    ///Predicate for the gates that doesn't contain circles
    static var notContainsCircle: Self {
        Predicate {
            [.or, .and, .xor].contains($0)
        }
    }
    
    ///Predicate for the gates that contain rectangles
    static var containsRectangle: Self {
        Predicate {
            [.and, .nand].contains($0)
        }
    }
    
    ///Predicate for the gates that doesn't  contain rectangles
    static var notContainsRectangle: Self {
        Predicate {
            [.not, .or, .nor, .xor, .xnor].contains($0)
        }
    }
    
    ///Predicate for the gates that contain triangles
    static var containsTriangle: Self {
        Predicate {
            [.not, .or, .nor, .xor, .xnor].contains($0)
        }
    }
    
    ///Predicate for the gates that contain curved triangles
    static var notContainsCurvedTriangle: Self {
        Predicate {
            [.not].contains($0)
        }
    }
    
    ///Predicate for the gates that contain curved triangles
     static var notContainsStraightTriangle: Self {
         Predicate {
            [.or, .nor, .xor, .xnor].contains($0)
         }
     }
    
    ///Predicate for the gates that contain lines
    static var containsLine: Self {
        Predicate {
            [.xor, .xnor].contains($0)
        }
    }
    
    ///Predicate for the gates that doesn't contain lines
    static var notContainsLine: Self {
        Predicate {
            [.not, .or, .nor, .and, .nand].contains($0)
        }
    }
}

extension Predicate where Target == Gate {
    
    ///Predicate to determine if the gate is single input
    static var isSingleInput: Self {
        Predicate {
            if let _ = $0 as? Not { return true }
            if let _ = $0 as? Output { return true }
            return false
        }
    }
    
    ///Predicate to determine if a gate is a no input gate
    static var isNoInput: Self {
        Predicate {
            if let _ = $0 as? Input { return true }
            return false
        }
    }
    
}
