//
//  CGRect+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 03/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    
    ///Inflates the size of the CGRect to increase a ratio by it's center poiont
    ///- Parameter amount: Ratio to increase the CGRect by
    ///- Returns: CGRect increased by the `amount` ratio
    func inflate(by amount: CGFloat) -> CGRect {
        guard amount != 1.0, amount > 0.0 else { fatalError("Can't inflate by \(amount), not valid") }
        let ratio = (1.0 - amount) / 2.0
        return insetBy(dx: width * ratio, dy: height * ratio)
    }
    
}

