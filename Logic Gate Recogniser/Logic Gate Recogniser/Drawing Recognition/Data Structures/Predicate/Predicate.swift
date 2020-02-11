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

extension Predicate where Target == Shape {
   
    ///Predicate to check if the shape is a line, either `line` or `curvedLine`
    static var isLine: Self {
        Predicate {
            $0.type == .line || $0.type == .curvedLine
        }
    }
    
    ///Predicate to check if the shape is a triangle, either `line` or `curvedLine`
    static var isTriangle: Self {
        Predicate {
            $0.type == .curvedTriangle || $0.type == .straitTringle
        }
    }
}

extension Predicate where Target == Gate {
    
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
            [.not, .or, .xor, .xnor].contains($0)
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
