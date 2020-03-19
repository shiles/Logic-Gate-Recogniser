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

    /// Creates a CGRect at a central point of a given size
    ///- parameter center: The center point of the rectangle
    ///- parameter size: The size of the rectangle
    init(center: CGPoint, size: CGSize = CGSize(width: 20.0, height: 20.0)) {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
    
    ///Inflates the size of the CGRect to increase a ratio by it's center poiont
    ///- Parameter amount: Ratio to increase the CGRect by
    ///- Returns: CGRect increased by the `amount` ratio
    func inflate(by amount: CGFloat) -> CGRect {
        guard amount != 1.0, amount > 0.0 else { fatalError("Can't inflate by \(amount), not valid") }
        let ratio = (1.0 - amount) / 2.0
        return insetBy(dx: width * ratio, dy: height * ratio)
    }
    
    ///Squares out the current CGRect by taking it's height in both dimentions
    ///- Returns: Squared CGRect which is height x height of the original
    func squared() -> CGRect {
        return CGRect(origin: self.origin, size: CGSize(width: self.height, height: self.height))
    }
    
}

