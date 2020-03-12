//  Matrix.swift
//  Logic Gate Recogniser
//
//  Code initially created by Richard Ash on 10/28/16 for Swift Alorithm Club, under MIT open source license.
//  With updates for Swift 5, and updates and extensions for project made by Sonnie Hiles.
//  https://github.com/raywenderlich/swift-algorithm-club/tree/master/Strassen%20Matrix%20Multiplication
//

import Foundation
import UIKit

public struct Matrix<T: Number> {

    // MARK: - Martix Objects

    public enum Index {
        case row, column
    }

    public struct Size: Equatable {
        let rows: Int, columns: Int

        public static func == (lhs: Size, rhs: Size) -> Bool {
            return lhs.columns == rhs.columns && lhs.rows == rhs.rows
        }
    }

    // MARK: - Variables

    let rows: Int, columns: Int
    let size: Size
    var grid: [T]
    var isSquare: Bool { rows == columns }

    // MARK: - Init

    init(rows: Int, columns: Int, initialValue: T = T.zero) {
        self.rows = rows
        self.columns = columns
        self.size = Size(rows: rows, columns: columns)
        self.grid = Array(repeating: initialValue, count: rows * columns)
    }

    init(size: Int, initialValue: T = T.zero) {
        self.init(rows: size, columns: size, initialValue: initialValue)
    }
    
    init(from list: [T]) {
        self.init(rows: 1, columns: list.count, initialValue: T.zero)
        self[.row, 0] = list
    }
    
    init(from list: [[T]]) {
        self.init(rows: list.count, columns: list[0].count, initialValue: T.zero)
        for i in 0...list.lastIndex { self[.row, i] = list[i] }
    }

    // MARK: - Private Functions

    private func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    // MARK: - Subscript

    public subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }

  public subscript(type: Matrix.Index, value: Int) -> [T] {
    get {
        switch type {
            case .row:
                assert(indexIsValid(row: value, column: 0), "Index out of range")
                return Array(grid[(value * columns)..<(value * columns) + columns])
            case .column:
                assert(indexIsValid(row: 0, column: value), "Index out of range")
                return (0..<rows).map { grid[$0 * columns + value] }
        }
    }

    set {
        switch type {
            case .row:
                assert(newValue.count == columns)
                for (column, element) in newValue.enumerated() {
                    grid[(value * columns) + column] = element
                }
            case .column:
                assert(newValue.count == rows)
                for (row, element) in newValue.enumerated() {
                    grid[(row * columns) + value] = element
                }
        }
    }
  }

    // MARK: - Public Functions

    public func row(for columnIndex: Int) -> [T] {
        assert(indexIsValid(row: columnIndex, column: 0), "Index out of range")
        return Array(grid[(columnIndex * columns)..<(columnIndex * columns) + columns])
    }

    public func column(for rowIndex: Int) -> [T] {
        assert(indexIsValid(row: 0, column: rowIndex), "Index out of range")
        return (0..<rows).map { grid[$0 * columns + rowIndex]}
    }

    public func forEach(_ body: (Int, Int) throws -> Void) rethrows {
        for row in 0..<rows {
            for column in 0..<columns {
                try body(row, column)
            }
        }
    }
}

// MARK: - Multiplication

extension Matrix {
  public func matrixMultiply(by B: Matrix<T>) -> Matrix<T> {
    let A = self
    assert(A.columns == B.rows, "Two matricies can only be matrix mulitiplied if one has dimensions mxn & the other has dimensions nxp where m, n, p are in R")

    var C = Matrix<T>(rows: A.rows, columns: B.columns)

    for i in 0..<A.rows {
      for j in 0..<B.columns {
        C[i, j] = A[.row, i].dot(B[.column, j])
      }
    }

    return C
  }
}

// Term-by-term Matrix Math

extension Matrix: Addable {
    
    public static func +<T: Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        assert(lhs.size == rhs.size, "To term-by-term add matricies they need to be the same size!")
        let rows = lhs.rows
        let columns = lhs.columns

        var newMatrix = Matrix<T>(rows: rows, columns: columns)
        for row in 0..<rows {
            for column in 0..<columns {
                newMatrix[row, column] = lhs[row, column] + rhs[row, column]
            }
        }
        return newMatrix
    }

    public static func -<T: Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        assert(lhs.size == rhs.size, "To term-by-term subtract matricies they need to be the same size!")
        let rows = lhs.rows
        let columns = lhs.columns

        var newMatrix = Matrix<T>(rows: rows, columns: columns)
        for row in 0..<rows {
            for column in 0..<columns {
                newMatrix[row, column] = lhs[row, column] - rhs[row, column]
            }
        }
        return newMatrix
    }
}

extension Matrix: Multipliable {
    
    public static func *<T: Number>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        assert(lhs.size == rhs.size, "To term-by-term multiply matricies they need to be the same size!")
        let rows = lhs.rows
        let columns = lhs.columns

        var newMatrix = Matrix<T>(rows: rows, columns: columns)
        for row in 0..<rows {
            for column in 0..<columns {
                newMatrix[row, column] = lhs[row, column] * rhs[row, column]
            }
        }
        return newMatrix
    }
}

extension Matrix where T == CGFloat {
    
    /// Converts  a matrix of 2x1 CGFloat to CGPoint
    ///- Returns: A CGPoint using [x,y] format
    func toPoint() -> CGPoint {
        assert((self.rows == 1 && self.columns == 2), "Doesn't appear to be a point, needs two values - [X Y]")
        return CGPoint(x: self[.row, 0][0], y: self[.row, 0][1])
    }
}

extension Matrix {
    
    /// Buiilds a rotation matrix to rotate another vector
    ///- Returns: 2x2 rotation vector
    static func forRotation(angle: CGFloat) -> Matrix<CGFloat> {
        return Matrix<CGFloat>(from: [[cos(angle), cos(angle-(.pi/2))], [cos(angle+(.pi/2)), cos(angle)]])
    }
}
