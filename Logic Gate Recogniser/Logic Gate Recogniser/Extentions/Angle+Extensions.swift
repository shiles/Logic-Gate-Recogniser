//
//  File.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

typealias Angle = CGFloat

extension Angle {
    
    ///Converts a radion to degrees
    ///- Returns: Degree value of the radion
    func toDegrees() -> Angle { (self * 180) / .pi }
}
