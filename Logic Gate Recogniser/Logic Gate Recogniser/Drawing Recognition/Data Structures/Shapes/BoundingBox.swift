//
//  BoundingBox.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 15/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit

struct BoundingBox {
    let cornerPoints: CornerPoints
    let area: CGFloat
}

struct CornerPoints {
    let p1: CGPoint
    let p2: CGPoint
    let p3: CGPoint
    let p4: CGPoint
}

struct MinBoudingRect {
    let rotAngle: CGFloat
    let area: CGFloat
    let width: CGFloat
    let height: CGFloat
    let minX: CGFloat
    let maxX: CGFloat
    let minY: CGFloat
    let maxY: CGFloat
}
