//
//  UIBezierPath+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 13/02/2020.
//  Copyright © 2020 Sonnie Hiles. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    
    ///Sets the default drawing style for the path
    func setDefaultAttributes() {
        self.lineWidth = 10
        self.lineCapStyle = .round
        self.lineJoinStyle = .round
        UIColor.label.setStroke()
    }
    
    ///Scales the path to fit the bounding box and moves it to the location
    ///- Parameter boundingBox: Bounding box to scale too
    func scaleToFit(_ boundingBox: CGRect) {
        self.apply(CGAffineTransform(scaleX: boundingBox.width, y: boundingBox.height))
        self.apply(CGAffineTransform(translationX: boundingBox.minX, y: boundingBox.minY))
    }
    
}
