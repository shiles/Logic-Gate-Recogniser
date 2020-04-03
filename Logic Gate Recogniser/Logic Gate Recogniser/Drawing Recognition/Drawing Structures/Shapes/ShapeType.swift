//
//  ShapeType.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 03/04/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

enum ShapeType: Equatable {
    case line(type: LineType)
    case triangle(type: TriangleType = .unanalysed)
    case rectangle
    case circle
    case unknown
}

enum TriangleType: Equatable {
    case unanalysed
    case incomplete
    case straight
    case curved
}

enum LineType: Equatable {
    case straight
    case curved
}

extension ShapeType {
    
    var stringValue: String {
        switch(self){
        case .line(type: _):
            return "line"
        case .triangle(type: _):
            return "triangle"
        case .rectangle:
            return "rectangle"
        case .circle:
            return "circle"
        case .unknown:
            return "unknown"
        }
    }
    
    init(stringValue: String) {
        switch(stringValue){
        case "line":
            self = .line(type: .straight)
        case "triangle":
            self = .triangle(type: .unanalysed)
        case "rectangle":
            self = .rectangle
        case "circle":
            self = .circle
        default:
            self = .unknown
        }
    }
    
}
