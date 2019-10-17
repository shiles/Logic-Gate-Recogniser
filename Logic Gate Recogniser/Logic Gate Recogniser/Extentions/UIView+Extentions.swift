//
//  UIView+Extentions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 17/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners() {
        self.layer.cornerRadius = 40;
        self.layer.masksToBounds = true;
    }
}
