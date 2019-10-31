//
//  UIView+Extentions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 17/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit

extension UIView {
    
    ///Adds rounded corners to a view
    ///- Parameter radious: Radious of the corners, defualt value is 40
    func roundCorners(radious: CGFloat = 40) {
        self.layer.cornerRadius = radious;
        self.layer.masksToBounds = true;
    }
}
