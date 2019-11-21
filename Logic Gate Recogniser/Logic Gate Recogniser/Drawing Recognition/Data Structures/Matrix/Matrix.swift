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

// MARK: - Strassen Multiplication

extension Matrix {
    
    func strassenMatrixMultiply(by B: Matrix<T>) -> Matrix<T> {
        let A = self
        assert(A.columns == B.rows, "Two matricies can only be matrix mulitiplied if one has dimensions mxn & the other has dimensions nxp where m, n, p are in R")

        let n = max(A.rows, A.columns, B.rows, B.columns)
        let m = nextPowerOfTwo(after: n)

        var APrep = Matrix(size: m)
        var BPrep = Matrix(size: m)

        A.forEach { APrep[$0, $1] = A[$0, $1] }
        B.forEach { BPrep[$0, $1] = B[$0, $1] }

        let CPrep = APrep.strassenR(by: BPrep)
        var C = Matrix(rows: A.rows, columns: B.columns)
        for i in 0..<A.rows {
            for j in 0..<B.columns {
                C[i, j] = CPrep[i, j]
            }
        }

        return C
    }

    private func strassenR(by B: Matrix<T>) -> Matrix<T> {
        let A = self
        assert(A.isSquare && B.isSquare, "This function requires square matricies!")
        guard A.rows > 1 && B.rows > 1 else { return A * B }

        let n    = A.rows
        let nBy2 = n / 2

        var a = Matrix(size: nBy2)
        var b = Matrix(size: nBy2)
        var c = Matrix(size: nBy2)
        var d = Matrix(size: nBy2)
        var e = Matrix(size: nBy2)
        var f = Matrix(size: nBy2)
        var g = Matrix(size: nBy2)
        var h = Matrix(size: nBy2)

        for i in 0..<nBy2 {
            for j in 0..<nBy2 {
                a[i, j] = A[i, j]
                b[i, j] = A[i, j+nBy2]
                c[i, j] = A[i+nBy2, j]
                d[i, j] = A[i+nBy2, j+nBy2]
                e[i, j] = B[i, j]
                f[i, j] = B[i, j+nBy2]
                g[i, j] = B[i+nBy2, j]
                h[i, j] = B[i+nBy2, j+nBy2]
            }
        }

        let p1 = a.strassenR(by: f-h)       // a * (f - h)
        let p2 = (a+b).strassenR(by: h)     // (a + b) * h
        let p3 = (c+d).strassenR(by: e)     // (c + d) * e
        let p4 = d.strassenR(by: g-e)       // d * (g - e)
        let p5 = (a+d).strassenR(by: e+h)   // (a + d) * (e + h)
        let p6 = (b-d).strassenR(by: g+h)   // (b - d) * (g + h)
        let p7 = (a-c).strassenR(by: e+f)   // (a - c) * (e + f)

        let c11 = p5 + p4 - p2 + p6         // p5 + p4 - p2 + p6
        let c12 = p1 + p2                   // p1 + p2
        let c21 = p3 + p4                   // p3 + p4
        let c22 = p1 + p5 - p3 - p7         // p1 + p5 - p3 - p7

        var C = Matrix(size: n)
        for i in 0..<nBy2 {
            for j in 0..<nBy2 {
                C[i, j]           = c11[i, j]
                C[i, j+nBy2]      = c12[i, j]
                C[i+nBy2, j]      = c21[i, j]
                C[i+nBy2, j+nBy2] = c22[i, j]
            }
        }

        return C
    }

    private func nextPowerOfTwo(after n: Int) -> Int {
        return Int(pow(2, ceil(log2(Double(n)))))
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
