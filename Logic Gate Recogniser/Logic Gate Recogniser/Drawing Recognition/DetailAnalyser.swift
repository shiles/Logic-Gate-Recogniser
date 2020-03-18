//
//  DetailAnalyser.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 25/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

class DetailAnalyser {
    
    // MARK: Shape Analysis Functions
    
    ///Analyses a triangle to determine if each of it's lines are straight or curved
    ///- Parameter triangle: Input triangle
    ///- Returns: Detailed triangle
    func analyseTriangle(triangle: Stroke) -> ShapeType {
        switch(straightLines(in: triangle).count) {
        case 0..<3:
            return .incompleteTriangle
        case 3:
            return .straightTriangle
        default:
            return .curvedTriangle
        }
    }
    
    ///Analyses a rectangle to determine if it's rectangular or a curved line
    ///- Parameter rectangle: Input rectangle
    ///- Returns: Detailed rectangle
    func analyseRectangle(rectangle: Stroke) -> ShapeType {
        let lines = straightLines(in: rectangle)
        
        switch(lines.count) {
        case 0...3:
            return .curvedLine
        default:
            return .rectangle
        }
    }
    
    // MARK: Line Recognition Functions
    
    ///Finds and counts the number of stright lines in a stoke
    ///- Parameter stroke: Stroke to look for straight lines in
    ///- Returns: Number of straight lines found
    private func straightLines(in stroke: Stroke) -> [Line] {
        connectSimilarLines(lines: recogniseStraightLines(points: stroke))
    }
    
    ///Finds all the straight lines within the points.
    ///- Parameter points: Points of the line to check for straight lines
    ///- Returns: A list of straight lines
    private func recogniseStraightLines(points: [CGPoint]) -> [Line] {
        if isStraightLine(points: points) {
            return [ Line(startPoint: points.last!, endPoint:  points.first!) ]
        }
        
        let split = points.split()
        return recogniseStraightLines(points: split.right) + recogniseStraightLines(points: split.left)
    }
        
    // MARK: Manipulation Functions
    
    ///Connects adjacent lines if their vectors are similar, combining the lines into one straight line
    ///- Parameter lines: Input lines
    ///- Returns: Connected straight lines
    private func connectSimilarLines(lines: [Line]) -> [Line] {
        var combinedLines = lines
        
        for i in 0...combinedLines.count {
            guard let first = combinedLines[safe: i], let second = combinedLines[safe: i+1] else { break }
            
            if isVectorSimilar(between: first.vector, second.vector) {
                combinedLines[i] = Line(startPoint: first.startPoint, endPoint: second.endPoint)
                combinedLines.remove(at: i+1)
            }
        }

        return combinedLines
    }
    
    // MARK: Translation Functions
 
    ///Translates a list of points so to the origin, (0,0) and then rotates the line proportionally along the y axis to allow comparison along the x co-ordinates
    ///devience from a relative 0 point.
    ///- Parameter points: Points of the line to translate
    ///- Returns: Translated points relative to input
    private func translate(points: [CGPoint]) -> [CGPoint] {
        guard let first = points.first, let last = points.last else { fatalError("Translation needs at least 2 points") }
        
        let translation = CGAffineTransform(translationX: -first.x, y: -first.y)
        let rotation = CGAffineTransform(rotationAngle: rotationAngle(between: first, last))
        
        return points.map{ $0.applying(translation).applying(rotation) }
    }
    
    /// Finds the rotation angle between a first and a last point, used to rotate the whole line relative to this slope.
    ///- Parameter first: First point of the line
    ///- Parameter last: Last point of the line
    ///- Returns: Angle between points in radions
    private func rotationAngle(between first: CGPoint, _ last: CGPoint) -> CGFloat {
        let slope = (last.x - first.x) / (last.y - first.y)
        return atan(slope)
    }

    // MARK: Boolean Check Functions
    
    ///Checks if the lines straight based on an allowed devience via root mean squared of all the points.
    ///- Parameter points: Points of the line to check if is straight
    ///- Parameter allowedDevience: Allowed devience to determine if the line is straight or not, defualt is 5.0
    ///- Returns: A boolean indicating if the line is straight or not
    private func isStraightLine(points: [CGPoint], allowedDevience: CGFloat = 10.0) -> Bool {
        let xCoords = translate(points: points).map(\.x)
        return xCoords.rootMeanSquared() < allowedDevience
    }
    
    ///Checks if two vectors are similar, and therefore can be combined
    ///- Parameter first: First point, the vector to use as a base for the bounding box
    ///- Parameter second: Second point, the vector to check if is within the bounding box
    ///- Parameter allowedDevience: Allowed devience to determine if the lines should be connecting or not
    ///- Returns: A boolean indicating if the vector is similar in direction
    private func isVectorSimilar(between first: CGVector, _ second: CGVector, allowedDevience: CGFloat = 0.7) -> Bool {
        let v1 = first.normalized()
        let v2 = second.normalized()
        
        let xDif = abs(v1.dx - v2.dx)
        let yDif = abs(v1.dy - v2.dy)
        
        return xDif < allowedDevience && yDif < allowedDevience
    }
}
