//
//  ShapeAttributes.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 13/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

struct ShapeAttributes {
    ///Convex Hull
    let convexHull: ConvexHull
    
    ///Convex Hull Perimeter Squared / Area Convex Hull
    let thinnessRatio: CGFloat
    
    ///Area Largest Triangle / Area Convex Hull
    let triangleAreaRatio: CGFloat
    
    ///Perimeter Convex Hull / Perimeter Bounding Box
    let rectanglePerimeterRatio: CGFloat
}
