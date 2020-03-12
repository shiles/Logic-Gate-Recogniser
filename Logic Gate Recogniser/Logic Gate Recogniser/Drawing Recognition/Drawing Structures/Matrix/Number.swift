//
//  Number.swift
//  Logic Gate Recogniser
//
//  Created by Richard Ash on 10/28/16 for Swift Alorithm Club, under MIT open source license.
//  With updates for Swift 5, and updates and extensions for project made by Sonnie Hiles.
//  https://github.com/raywenderlich/swift-algorithm-club/tree/master/Strassen%20Matrix%20Multiplication
//

import Foundation
import UIKit

public protocol Number: Multipliable, Addable {
    static var zero: Self { get }
}

public protocol Addable {
    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
}

public protocol Multipliable {
    static func * (lhs: Self, rhs: Self) -> Self
}

extension Int: Number {
    public static var zero: Int { 0 }
}

extension Double: Number {
    public static var zero: Double { 0.0 }
}

extension Float: Number {
    public static var zero: Float { 0.0 }
}

extension CGFloat: Number {
    public static var zero: CGFloat { 0.0 }
}

extension Array where Element: Number {
    
    public func dot(_ b: Array<Element>) -> Element {
        let a = self
        assert(a.count == b.count, "Can only take the dot product of arrays of the same length!")
        let c = a.indices.map { a[$0] * b[$0] }
        return c.reduce(Element.zero, +)
    }
}
