//
//  Shape.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/01/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation

struct Shape {
    let type: ShapeType
}

enum ShapeType: String {
    case Line, Circle, Triangle, Rectangle, Unknown
}
