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
    
    func toDegrees() -> Angle {
        return (self * 180) / .pi
    }
}
