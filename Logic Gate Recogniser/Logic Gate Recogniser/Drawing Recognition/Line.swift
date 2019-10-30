//
//  Line.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 30/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

struct Line: Equatable {
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    var length: CGFloat {
        return ((endPoint.x - startPoint.x).squared() + (endPoint.y - startPoint.y).squared()).squareRoot()
    }
}
