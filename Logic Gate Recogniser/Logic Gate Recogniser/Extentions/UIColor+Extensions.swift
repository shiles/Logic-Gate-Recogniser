//
//  UIColor+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 30/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hue: Double) {
        self.init(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1)
    }
    
}
