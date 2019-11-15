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
    
    ///The index of the last object within the arrray
    var lastIndex: Int { self.count - 1 }
    
    ///Splits the array into two parts, with a single element overlap between the left and right sides of the split
    ///- Returns: Touple with left half and right half of array
    func split() -> (left: [Element], right: [Element]) {
        let max = self.count
        let half = max / 2
        return (left: Array(self[0 ..< half+1]), right: Array(self[half ..< max]))
    }
    
    ///Replaces the last element of an array with a new element
    ///- Parameter element: Element to replace the existing last value with
    ///- Returns: Array with new final element
    func replaceLast(_ element: Element) -> [Element] {
        var array = self.dropLast()
        array.append(element)
        return Array(array)
    }
    
}

extension Array where Element: FloatingPoint {
    
    ///Root mean squares the value within the array to find average devience
    ///- Returns: Root mean square value for the values within the array 
    func rootMeanSquared() -> CGFloat {
        return (self.map { ($0 as! CGFloat).squared() }.reduce(0, +) / CGFloat(self.count)).squareRoot()
    }
    
}

extension Array where Element: Hashable {
    
    ///Return all the unique values in the array
    ///- Returns: Unquie values within the array
    var unique: [Element] {
        return Array(Set(self))
    }
}

extension Array where Element == CGPoint {
    
    ///Transposed matrix of all the points, with the first row being all X values and second row being Y values
    var transposedMatrix: Matrix<CGFloat> {
        return Matrix<CGFloat>(from: [self.map { $0.x }, self.map { $0.y }])
    }
}
